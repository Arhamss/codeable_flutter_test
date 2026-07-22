// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_prod.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: env/.env.production
final class _EnvProd {
  static const String baseUrl = 'https://api.example.com/';

  static const String apiVersion = 'v1';

  static const List<int> _enviedkeymapboxApiKey = <int>[
    3178271138,
    2495042481,
    4109247996,
    1921386334,
    5061321,
    472605503,
    577853937,
    95574873,
    788775205,
    2235610111,
    3230833858,
    129189184,
    3153481778,
    3074607470,
    1986576396,
    3185820492,
    3350959620,
    3538478887,
    4011606934,
  ];

  static const List<int> _envieddatamapboxApiKey = <int>[
    3178271227,
    2495042558,
    4109247913,
    1921386252,
    5061270,
    472605554,
    577853872,
    95574793,
    788775271,
    2235610032,
    3230833818,
    129189151,
    3153481843,
    3074607422,
    1986576453,
    3185820435,
    3350959695,
    3538478946,
    4011606991,
  ];

  static final String mapboxApiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddatamapboxApiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddatamapboxApiKey[i] ^ _enviedkeymapboxApiKey[i]),
  );

  static const List<int> _enviedkeystripePublishableKey = <int>[
    414609647,
    3770326629,
    350687425,
    2907053805,
    814519147,
    3122258929,
    1825210497,
    3476972173,
    3117557639,
    1222288404,
    2418390251,
    1544028729,
    3282183161,
    1833090271,
    4029436675,
    1516541112,
    3391670936,
    3507768566,
    2043723112,
    429498872,
    114004932,
    2977108336,
    376589754,
    673846206,
    2926091699,
    3834327835,
    2055556954,
  ];

  static const List<int> _envieddatastripePublishableKey = <int>[
    414609590,
    3770326570,
    350687380,
    2907053759,
    814519092,
    3122258850,
    1825210581,
    3476972255,
    3117557710,
    1222288452,
    2418390190,
    1544028774,
    3282183081,
    1833090186,
    4029436737,
    1516541172,
    3391670993,
    3507768485,
    2043723040,
    429498809,
    114004870,
    2977108284,
    376589823,
    673846241,
    2926091768,
    3834327902,
    2055556867,
  ];

  static final String stripePublishableKey = String.fromCharCodes(
    List<int>.generate(
      _envieddatastripePublishableKey.length,
      (int i) => i,
      growable: false,
    ).map(
      (int i) =>
          _envieddatastripePublishableKey[i] ^
          _enviedkeystripePublishableKey[i],
    ),
  );

  static const String googleClientId = 'YOUR_GOOGLE_CLIENT_ID';

  static const String socketUrl = 'wss://api.example.com/ws';
}
