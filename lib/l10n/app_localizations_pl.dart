// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get calculate => 'Oblicz';

  @override
  String get calculator => 'Kalkulator';

  @override
  String get records => 'Rekordy';

  @override
  String get settings => 'Ustawienia';

  @override
  String get length => 'Długość';

  @override
  String get stroke => 'Styl';

  @override
  String get splits => 'Międzyczasy';

  @override
  String get discipline => 'Dyscyplina';

  @override
  String get limits => 'Limity';

  @override
  String get limitsText =>
      '1) Mistrzostwa Świata i Igrzyska Olimpijskie: Limity są pobierane z oficjalnej strony World Aquatics. Dla niektórych krajów mogą być inne (zazwyczaj trudniejsze). \n\n2) Mistrzostwa Europy i Uniwersjada: Limity są ważne dla Czech Aquatics, a dla każdej innej federacji będą różne. Czeskie limity są oparte na 16. lub 8. miejscu z najlepszych ostatnich 3 Mistrzostw Europy lub ostatniej Uniwersjady.';

  @override
  String get men => 'Mężczyźni';

  @override
  String get women => 'Kobiety';

  @override
  String get mixed => 'Mieszane';

  @override
  String get aquaPoints => 'Aqua Punkty';

  @override
  String get gender => 'Płeć';

  @override
  String get course => 'Basen';

  @override
  String get language => 'Język';

  @override
  String get colorTheme => 'Motyw kolorów';

  @override
  String get system => 'System';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get aboutApp => 'O aplikacji';

  @override
  String get close => 'Zamknij';

  @override
  String get lcm => 'LCM (50m)';

  @override
  String get scm => 'SCM (25m)';

  @override
  String get season => 'Sezon';

  @override
  String get min => 'min';

  @override
  String get sec => 'sek';

  @override
  String get hun => 'setne';

  @override
  String get freestyle => 'Styl dowolny';

  @override
  String get backstroke => 'Grzbietowy';

  @override
  String get butterfly => 'Motylkowy';

  @override
  String get breaststroke => 'Kraul klasyczny';

  @override
  String get medley => 'Zmieszany';

  @override
  String get january => 'Styczeń';

  @override
  String get february => 'Luty';

  @override
  String get march => 'Marzec';

  @override
  String get april => 'Kwiecień';

  @override
  String get may => 'Maj';

  @override
  String get june => 'Czerwiec';

  @override
  String get july => 'Lipiec';

  @override
  String get august => 'Sierpień';

  @override
  String get september => 'Wrzesień';

  @override
  String get october => 'Październik';

  @override
  String get november => 'Listopad';

  @override
  String get december => 'Grudzień';

  @override
  String get pointsSeason => 'Sezon dla punktów';

  @override
  String get pointsSeasonText =>
      'Ponieważ niektóre federacje używają starszych tabel punktowych do własnych celów, dodaliśmy możliwość ich wyboru. Dla osób nieznających tych terminów, wyjaśniamy. \n\nNa przykład opcja „sezon 24/25” oznacza, że punkty są obliczane według tabel opublikowanych 01.09.2024 dla krótkiego basenu i 01.01.2025 dla długiego basenu. Tabele są ważne przez rok od daty publikacji. \n\nJeśli pojawia się nowy sezon zimowy (krótki basen), a nadal nie ma nowych tabel dla sezonu letniego (długi basen), używane są ostatnie letnie tabele.';

  @override
  String get disciplineNotExist => 'Wybrana dyscyplina nie istnieje!';

  @override
  String get enterTimeWarn =>
      'Proszę wprowadzić czas lub Aqua Punkty, aby obliczyć!';

  @override
  String get splitsInfo =>
      'Jeśli klikniesz na kafelek rekordu świata, zobaczysz międzyczasy.';

  @override
  String get limitsInfo =>
      'Limity zgodne z regulacjami Czech Aquatics. Gdy pokazane są dwa czasy, reprezentują limit A i B, przy czym limity B dotyczą tylko pływaków urodzonych w 2005 (2006) roku lub później.';

  @override
  String get calcualteTooltip => 'Oblicz Aqua Punkty z czasu.';

  @override
  String get clearTooltip => 'Wyczyść wszystkie pola.';

  @override
  String get rateApp => 'Oceń aplikację';

  @override
  String get newFeature => 'New Feature';

  @override
  String get newFeatureText =>
      'Teraz możesz przytrzymać (długie naciśnięcie) wiersz limitu, aby zobaczyć punkty zamiast czasu.';

  @override
  String get gotIt => 'Rozumiem';

  @override
  String get dontShowAgain => 'Nie pokazuj ponownie';

  @override
  String recordUpdated(String date) {
    return 'Rekordy zaktualizowane: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Ważne dla sezonu: zima $date';
  }
}
