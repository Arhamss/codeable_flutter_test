export 'package:codeable_flutter_test/l10n/gen/app_localizations.dart';
export 'package:codeable_flutter_test/l10n/localization_service.dart';

import 'package:flutter/material.dart';
import 'package:codeable_flutter_test/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
