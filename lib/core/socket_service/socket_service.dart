import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:codeable_flutter_test/config/env/app_env.dart';
import 'package:codeable_flutter_test/core/app_preferences/app_preferences.dart';
import 'package:codeable_flutter_test/core/socket_service/socket_status.dart';
import 'package:codeable_flutter_test/utils/helpers/logger_helper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Centralized WebSocket connection manager.
///
/// Handles authentication, room management, automatic reconnection,
/// and exposes typed broadcast streams for downstream consumers.
///
/// Usage:
/// ```dart
/// final socket = Injector.resolve<SocketService>();
/// await socket.connect('<room-or-channel-id>');
/// socket.messages.listen((data) => print(data));
/// ```
class SocketService {
  SocketService({required AppPreferences appPreferences})
    : _appPreferences = appPreferences;

  final AppPreferences _appPreferences;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  String? _roomId;
  SocketStatus _status = SocketStatus.disconnected;
  bool _isDisposed = false;

  Timer? _reconnectTimer;
  static const _reconnectDelay = Duration(seconds: 3);

  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  /// Raw broadcast stream of parsed JSON messages from the server.
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  SocketStatus get status => _status;
  bool get isConnected => _status == SocketStatus.connected;

  // ---------------------------------------------------------------------------
  // Connection lifecycle
  // ---------------------------------------------------------------------------

  /// Establishes the WebSocket connection and optionally joins a room.
  Future<void> connect([String? roomId]) async {
    if (_isDisposed) return;

    _roomId = roomId;

    if (_channel != null) {
      if (roomId != null) _joinRoom();
      return;
    }

    final token = _appPreferences.getAuthToken();
    if (token == null || token.isEmpty) {
      AppLogger.warning('SocketService: No auth token — skipping connect');
      return;
    }

    _status = SocketStatus.connecting;

    try {
      final wsUrl = Uri.parse(AppEnv.socketUrl);

      if (kDebugMode && !AppEnv.socketUrl.startsWith('wss://')) {
        AppLogger.warning(
          'SocketService: socketUrl is not using a secure scheme (wss://): '
          '${AppEnv.socketUrl}',
        );
      }

      _channel = WebSocketChannel.connect(wsUrl);
      await _channel!.ready;

      _status = SocketStatus.connected;
      AppLogger.info('SocketService: Connected');

      // Authenticate with the server
      _send('auth', token);
      if (roomId != null) _joinRoom();
      _listenToMessages();
    } catch (e) {
      AppLogger.error('SocketService: Connection error', e);
      _status = SocketStatus.error;
      _scheduleReconnect();
    }
  }

  /// Tears down the current connection and cleans up.
  void disconnect() {
    if (_channel == null) return;

    _leaveRoom();
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _channel?.sink.close();
    _channel = null;
    _status = SocketStatus.disconnected;
    AppLogger.info('SocketService: Disconnected');
  }

  /// Disconnects and reconnects with a fresh token.
  void refresh() {
    final roomId = _roomId;
    disconnect();
    if (roomId != null) {
      connect(roomId);
    }
  }

  /// Call on logout to fully tear down and clear room state.
  void reset() {
    disconnect();
    _roomId = null;
  }

  void dispose() {
    _isDisposed = true;
    reset();
    _messageController.close();
  }

  /// Send a custom event with arbitrary data to the server.
  void sendEvent(String event, dynamic data) => _send(event, data);

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  void _listenToMessages() {
    _subscription = _channel?.stream.listen(
      (data) {
        if (_isDisposed) return;

        try {
          final message = jsonDecode(data as String) as Map<String, dynamic>;
          _messageController.add(message);
        } catch (e) {
          AppLogger.error('SocketService: Failed to parse message', e);
        }
      },
      onError: (Object error) {
        AppLogger.error('SocketService: Stream error', error);
        _status = SocketStatus.error;
        _scheduleReconnect();
      },
      onDone: () {
        if (_status != SocketStatus.disconnected) {
          AppLogger.warning('SocketService: Connection lost — reconnecting');
          _status = SocketStatus.reconnecting;
          _channel = null;
          _scheduleReconnect();
        }
      },
    );
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      _channel = null;
      connect(_roomId);
    });
  }

  void _send(String event, dynamic data) {
    _channel?.sink.add(jsonEncode({'event': event, 'data': data}));
  }

  void _joinRoom() {
    if (_roomId == null || _channel == null) return;
    _send('join:room', _roomId);
    AppLogger.debug('SocketService: Joined room $_roomId');
  }

  void _leaveRoom() {
    if (_roomId == null || _channel == null) return;
    _send('leave:room', _roomId);
    AppLogger.debug('SocketService: Left room $_roomId');
  }
}
