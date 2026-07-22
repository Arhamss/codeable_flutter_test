import 'package:dio/dio.dart';
import 'package:codeable_flutter_test/core/app_preferences/app_preferences.dart';
import 'package:codeable_flutter_test/core/endpoints/endpoints.dart';
import 'package:codeable_flutter_test/exports.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._appPreferences, this._dio);

  final AppPreferences _appPreferences;
  final Dio _dio;
  bool _isRefreshing = false;
  Future<String?>? _refreshTokenFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _appPreferences.getAuthToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Prevent a refresh storm: if this request was already retried after a
      // refresh and still got a 401, give up instead of looping.
      if (err.requestOptions.extra['retried'] == true) {
        handler.next(err);
        return;
      }

      final newToken = await _handleTokenRefresh();

      if (newToken != null) {
        err.requestOptions.extra['retried'] = true;
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await _dio.fetch<dynamic>(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    }

    return handler.next(err);
  }

  Future<String?> _handleTokenRefresh() async {
    if (_isRefreshing) {
      return _refreshTokenFuture;
    }

    _isRefreshing = true;
    _refreshTokenFuture = _refreshToken();

    try {
      return await _refreshTokenFuture;
    } finally {
      _isRefreshing = false;
      _refreshTokenFuture = null;
    }
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = _appPreferences.getRefreshToken();
      if (refreshToken == null) {
        await _appPreferences.clearAuthData();
        _navigateToSplash();
        return null;
      }

      final response = await _dio.post<dynamic>(
        '${Endpoints.baseUrl}/${Endpoints.refresh}',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final newToken =
            data is Map<String, dynamic> ? data['token'] as String? : null;

        if (newToken == null || newToken.isEmpty) {
          await _appPreferences.clearAuthData();
          _navigateToSplash();
          return null;
        }

        await _appPreferences.setAuthToken(newToken);

        // Persist a rotated refresh token if the server returned one.
        final rotatedRefreshToken =
            data is Map<String, dynamic> ? data['refreshToken'] as String? : null;
        if (rotatedRefreshToken != null && rotatedRefreshToken.isNotEmpty) {
          await _appPreferences.setRefreshToken(rotatedRefreshToken);
        }

        return newToken;
      } else {
        await _appPreferences.clearAuthData();
        _navigateToSplash();
        return null;
      }
    } catch (e) {
      await _appPreferences.clearAuthData();
      _navigateToSplash();
      return null;
    }
  }

  void _navigateToSplash() {
    final context = AppRouter.appContext;
    if (context != null) {
      context.goNamed(AppRouteNames.splash);
    }
  }
}
