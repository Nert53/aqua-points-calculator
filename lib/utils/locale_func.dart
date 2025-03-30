import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String getLocalizedStroke(BuildContext context, String stroke) {
  switch (stroke.toLowerCase()) {
    case 'freestyle':
      return AppLocalizations.of(context)!.freestyle;
    case 'backstroke':
      return AppLocalizations.of(context)!.backstroke;
    case 'breaststroke':
      return AppLocalizations.of(context)!.breaststroke;
    case 'butterfly':
      return AppLocalizations.of(context)!.butterfly;
    case 'medley':
      return AppLocalizations.of(context)!.medley;
    default:
      return AppLocalizations.of(context)!.freestyle;
  }
}

String getLocalizedGender(BuildContext context, String gender) {
  switch (gender.toLowerCase()) {
    case 'men':
      return AppLocalizations.of(context)!.men;
    case 'women':
      return AppLocalizations.of(context)!.women;
    case 'mixed':
      return AppLocalizations.of(context)!.mixed;
    default:
      return AppLocalizations.of(context)!.men;
  }
}

String getLocalizedCourse(BuildContext context, String course) {
  switch (course.toLowerCase()) {
    case 'lcm':
      return AppLocalizations.of(context)!.lcm;
    case 'scm':
      return AppLocalizations.of(context)!.scm;
    default:
      return AppLocalizations.of(context)!.lcm;
  }
}

String getLocalizedMonth(BuildContext context, String month) {
  switch (month.toLowerCase()) {
    case 'january':
      return AppLocalizations.of(context)!.january;
    case 'february':
      return AppLocalizations.of(context)!.february;
    case 'march':
      return AppLocalizations.of(context)!.march;
    case 'april':
      return AppLocalizations.of(context)!.april;
    case 'may':
      return AppLocalizations.of(context)!.may;
    case 'june':
      return AppLocalizations.of(context)!.june;
    case 'july':
      return AppLocalizations.of(context)!.july;
    case 'august':
      return AppLocalizations.of(context)!.august;
    case 'september':
      return AppLocalizations.of(context)!.september;
    case 'october':
      return AppLocalizations.of(context)!.october;
    case 'november':
      return AppLocalizations.of(context)!.november;
    case 'december':
      return AppLocalizations.of(context)!.december;
    default:
      return AppLocalizations.of(context)!.january;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
