// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env_stg.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: env/.env.staging
final class _EnvStg {
  static const String baseUrl = 'https://api.example.com/';

  static const String apiVersion = 'v1';

  static const List<int> _enviedkeymapboxApiKey = <int>[
    1461716762,
    2251232335,
    1399865085,
    3054849254,
    3933899672,
    827246840,
    1196388870,
    929200004,
    1612319457,
    607819511,
    2052092880,
    671311630,
    3497144773,
    1408411839,
    2224810596,
    3339125567,
    2276459834,
    2607903894,
    2700828602,
  ];

  static const List<int> _envieddatamapboxApiKey = <int>[
    1461716803,
    2251232256,
    1399865000,
    3054849204,
    3933899719,
    827246773,
    1196388935,
    929200084,
    1612319395,
    607819448,
    2052092808,
    671311697,
    3497144708,
    1408411887,
    2224810541,
    3339125600,
    2276459889,
    2607903955,
    2700828643,
  ];

  static final String mapboxApiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddatamapboxApiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddatamapboxApiKey[i] ^ _enviedkeymapboxApiKey[i]),
  );

  static const List<int> _enviedkeystripePublishableKey = <int>[
    511026928,
    2535780511,
    2736633338,
    273293402,
    3009216058,
    4241612080,
    1731740252,
    945707132,
    1780648710,
    3503322116,
    50094569,
    2936305100,
    2267857343,
    1979320562,
    3536535738,
    779940703,
    792365308,
    4282141663,
    4294059790,
    144422148,
    1298563850,
    1571365205,
    3474802918,
    2412769567,
    748137883,
    2171584699,
    3722139456,
  ];

  static const List<int> _envieddatastripePublishableKey = <int>[
    511026857,
    2535780560,
    2736633263,
    273293320,
    3009216101,
    4241612131,
    1731740168,
    945707054,
    1780648783,
    3503322196,
    50094508,
    2936305043,
    2267857391,
    1979320487,
    3536535800,
    779940627,
    792365237,
    4282141580,
    4294059846,
    144422213,
    1298563912,
    1571365145,
    3474802851,
    2412769600,
    748137936,
    2171584766,
    3722139417,
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
