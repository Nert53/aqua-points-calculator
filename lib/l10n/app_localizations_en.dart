// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get calculate => 'Calculate';

  @override
  String get calculator => 'Calculator';

  @override
  String get records => 'Records';

  @override
  String get settings => 'Settings';

  @override
  String get length => 'Length';

  @override
  String get stroke => 'Stroke';

  @override
  String get splits => 'Splits';

  @override
  String get discipline => 'Discipline';

  @override
  String get limits => 'Limits';

  @override
  String get men => 'Men';

  @override
  String get women => 'Women';

  @override
  String get mixed => 'Mixed';

  @override
  String get aquaPoints => 'Aqua Points';

  @override
  String get gender => 'Gender';

  @override
  String get course => 'Course';

  @override
  String get language => 'Language';

  @override
  String get colorTheme => 'Color Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get aboutApp => 'About App';

  @override
  String get close => 'Close';

  @override
  String get lcm => 'LCM (50m)';

  @override
  String get scm => 'SCM (25m)';

  @override
  String get season => 'Season';

  @override
  String get min => 'min';

  @override
  String get sec => 'sec';

  @override
  String get hun => 'hun';

  @override
  String get freestyle => 'Freestyle';

  @override
  String get backstroke => 'Backstroke';

  @override
  String get butterfly => 'Butterfly';

  @override
  String get breaststroke => 'Breaststroke';

  @override
  String get medley => 'Medley';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get pointsSeason => 'Season for points';

  @override
  String get disciplineNotExist => 'Selected discipline does not exist!';

  @override
  String get enterTimeWarn => 'Please enter time/Aqua Points to calculate!';

  @override
  String get splitsInfo => 'If you click on the world record tile, you will see the split times.';

  @override
  String recordUpdated(String date) {
    return 'Records updated: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Valid for season: $date';
  }
}
