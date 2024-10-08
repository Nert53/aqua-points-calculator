import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  switch(gender.toLowerCase()){
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
  switch(course.toLowerCase()){
    case 'lcm':
      return AppLocalizations.of(context)!.lcm;
    case 'scm':
      return AppLocalizations.of(context)!.scm;
    default:
      return AppLocalizations.of(context)!.lcm;
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
}
