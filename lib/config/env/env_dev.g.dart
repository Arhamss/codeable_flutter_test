// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_dev.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: env/.env.development
final class _EnvDev {
  static const String baseUrl = 'https://api.example.com/';

  static const String apiVersion = 'v1';

  static const List<int> _enviedkeymapboxApiKey = <int>[
    3890005480,
    2991766698,
    2192033737,
    559204126,
    2624405198,
    2714686645,
    2181333782,
    3456934941,
    2624453044,
    1934804537,
    1137392639,
    2937664344,
    3541353925,
    795570094,
    455985746,
    1272313326,
    1665314768,
    3764703709,
    3259103739,
  ];

  static const List<int> _envieddatamapboxApiKey = <int>[
    3890005425,
    2991766757,
    2192033692,
    559204172,
    2624405137,
    2714686712,
    2181333847,
    3456934989,
    2624453110,
    1934804598,
    1137392551,
    2937664263,
    3541353860,
    795570174,
    455985691,
    1272313265,
    1665314715,
    3764703640,
    3259103650,
  ];

  static final String mapboxApiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddatamapboxApiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddatamapboxApiKey[i] ^ _enviedkeymapboxApiKey[i]),
  );

  static const List<int> _enviedkeystripePublishableKey = <int>[
    3543672534,
    296802580,
    609422106,
    2993705775,
    1636528817,
    3305615516,
    1512310465,
    2599472124,
    2810890250,
    1511968464,
    1246005758,
    4196380080,
    3236904632,
    2667909445,
    225681335,
    150071630,
    3718716751,
    2222251544,
    3121898706,
    3718355548,
    2314959062,
    3776226535,
    2688474892,
    1517746679,
    3411295352,
    2915408208,
    3490014117,
  ];

  static const List<int> _envieddatastripePublishableKey = <int>[
    3543672463,
    296802651,
    609422159,
    2993705853,
    1636528878,
    3305615567,
    1512310421,
    2599472046,
    2810890307,
    1511968384,
    1246005691,
    4196380143,
    3236904680,
    2667909392,
    225681397,
    150071554,
    3718716678,
    2222251595,
    3121898650,
    3718355485,
    2314958996,
    3776226475,
    2688474953,
    1517746600,
    3411295283,
    2915408149,
    3490014204,
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
