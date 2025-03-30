// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get calculate => 'Calcola';

  @override
  String get calculator => 'Calcolatore';

  @override
  String get records => 'Records';

  @override
  String get settings => 'Impostazioni';

  @override
  String get length => 'Vasca';

  @override
  String get stroke => 'Stile';

  @override
  String get splits => 'Passaggi';

  @override
  String get discipline => 'Gara';

  @override
  String get limits => 'Tempi Limite';

  @override
  String get men => 'Uomini';

  @override
  String get women => 'Donne';

  @override
  String get mixed => 'Mixed';

  @override
  String get aquaPoints => 'Aqua Points';

  @override
  String get gender => 'Sesso';

  @override
  String get course => 'Vasca';

  @override
  String get language => 'Lingua';

  @override
  String get colorTheme => 'Colore Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get aboutApp => 'About App';

  @override
  String get close => 'Chiudi';

  @override
  String get lcm => 'LCM (50m)';

  @override
  String get scm => 'SCM (25m)';

  @override
  String get season => 'Stagione';

  @override
  String get min => 'min';

  @override
  String get sec => 'sec';

  @override
  String get hun => 'cent';

  @override
  String get freestyle => 'Stile Libero';

  @override
  String get backstroke => 'Dorso';

  @override
  String get butterfly => 'Farfalla';

  @override
  String get breaststroke => 'Rana';

  @override
  String get medley => 'Misti';

  @override
  String get january => 'Gennaio';

  @override
  String get february => 'Febbraio';

  @override
  String get march => 'Marzo';

  @override
  String get april => 'Aprile';

  @override
  String get may => 'Maggio';

  @override
  String get june => 'Giugno';

  @override
  String get july => 'Luglio';

  @override
  String get august => 'Agosto';

  @override
  String get september => 'Settembre';

  @override
  String get october => 'Ottobre';

  @override
  String get november => 'Novembre';

  @override
  String get december => 'Dicembre';

  @override
  String get pointsSeason => 'Stagione per punti';

  @override
  String get disciplineNotExist => 'La gara scelta non esiste!';

  @override
  String get enterTimeWarn => 'Per favore inserisci un tempo/da calcolare per Aqua Points!';

  @override
  String get splitsInfo => 'Se clicchi sulla casella del record del mondo vedrai i passaggi.';

  @override
  String recordUpdated(String date) {
    return 'Records aggiornati al: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Valido per la stagione: $date';
  }
}
