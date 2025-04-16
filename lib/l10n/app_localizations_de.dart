// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get calculate => 'Berechnen';

  @override
  String get calculator => 'Rechner';

  @override
  String get records => 'Rekorde';

  @override
  String get settings => 'Einstellungen';

  @override
  String get length => 'Länge';

  @override
  String get stroke => 'Stil';

  @override
  String get splits => 'zwischenzeiten';

  @override
  String get discipline => 'Disziplin';

  @override
  String get limits => 'Normzeiten';

  @override
  String get limitsText => '1) Weltmeisterschaften und Olympische Spiele - Die Limits werden von der offiziellen Website von World Aquatics übernommen. Für einige Länder können die Limits unterschiedlich sein (meistens strenger). \n\n2) Europameisterschaften und Universiade - Die Limits gelten für die Czech Aquatics und können für andere Föderationen unterschiedlich sein. Die tschechischen Limits basieren auf dem 16. oder 8. Platz bei den besten drei letzten Europameisterschaften oder der letzten Universiade.';

  @override
  String get men => 'Männer';

  @override
  String get women => 'Frauen';

  @override
  String get mixed => 'Gemischt';

  @override
  String get aquaPoints => 'Aqua Punkte';

  @override
  String get gender => 'Geschlecht';

  @override
  String get course => 'Kurs';

  @override
  String get language => 'Sprache';

  @override
  String get colorTheme => 'Farbschema';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get close => 'Schließen';

  @override
  String get lcm => 'Lang (50m)';

  @override
  String get scm => 'Kurz (25m)';

  @override
  String get season => 'Jahreszeit';

  @override
  String get min => 'min';

  @override
  String get sec => 'sek';

  @override
  String get hun => 'hun';

  @override
  String get freestyle => 'Freistil';

  @override
  String get backstroke => 'Rücken';

  @override
  String get butterfly => 'Schmetterling';

  @override
  String get breaststroke => 'Brust';

  @override
  String get medley => 'Lagen';

  @override
  String get january => 'Januar';

  @override
  String get february => 'Februar';

  @override
  String get march => 'März';

  @override
  String get april => 'April';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juni';

  @override
  String get july => 'Juli';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'Oktober';

  @override
  String get november => 'November';

  @override
  String get december => 'Dezember';

  @override
  String get pointsSeason => 'Jahreszeiten für Punkteberechnung';

  @override
  String get pointsSeasonText => 'Da einige Föderationen ältere Punktetabellen für eigene Zwecke verwenden, haben wir die Möglichkeit hinzugefügt, diese auszuwählen. Für diejenigen, die mit diesen Begriffen nicht vertraut sind, erklären wir es. \n\nDie Option \'Saison 24/25\' bedeutet zum Beispiel, dass die Punkte gemäß den Tabellenausgaben vom 01.09.2024 für Kurzbahn und vom 01.01.2025 für Langbahn berechnet werden. Die Tabellen sind ab dem Veröffentlichungsdatum ein Jahr lang gültig. \n\nWenn eine neue Wintersaison (Kurzbahn) und noch keine neuen Tabellen für die Sommersaison (Langbahn) vorliegen, werden die letzten Sommer-Tabellen verwendet.';

  @override
  String get disciplineNotExist => 'Ausgewählte Disziplin gibt es nicht!';

  @override
  String get enterTimeWarn => 'Bitte geben Sie eine Zeit oder Points zum Berechnen ein!';

  @override
  String get splitsInfo => 'Wenn Sie auf die Kachel mit den Weltrekorden klicken, sehen Sie die Zwischenzeiten.';

  @override
  String get calcualteTooltip => 'Berechnen Sie Aqua Points aus der Zeit.';

  @override
  String get clearTooltip => 'Alle Felder löschen.';

  @override
  String recordUpdated(String date) {
    return 'Rekorde aktualisiert: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Gültig für die Saison: $date';
  }
}
