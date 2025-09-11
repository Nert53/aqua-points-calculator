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
  String get limitsText =>
      '1) Campionati del mondo e Olimpiadi - I limiti sono presi dal sito ufficiale di World Aquatics. Per alcuni paesi i limiti potrebbero essere diversi (di solito più severi). \n\n2) Campionati Europei e Universiade - I limiti sono validi per la Czech Aquatics di Nuoto e per le altre federazioni saranno diversi. I limiti cechi sono basati sul 16° o 8° posto nelle migliori 3 ultime edizioni dei Campionati Europei o nell\'ultima Universiade.';

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
  String get aboutApp => 'Informazioni sull\'app';

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
  String get pointsSeasonText =>
      'Poiché alcune federazioni utilizzano tabelle dei punteggi più vecchie per i propri scopi, abbiamo aggiunto la possibilità di sceglierle. Per chi non è familiare con questi termini, lo spieghiamo. \n\nAd esempio, l\'opzione \'stagione 24/25\' significa che i punteggi sono calcolati secondo le tabelle rilasciate il 01.09.2024 per la corta distanza e il 01.01.2025 per la lunga distanza. Le tabelle sono valide per un anno dalla data di rilascio. \n\nSe inizia una nuova stagione invernale (corta distanza) e non ci sono ancora nuove tabelle per la stagione estiva (lunga distanza), vengono utilizzate le ultime tabelle estive.';

  @override
  String get disciplineNotExist => 'La gara scelta non esiste!';

  @override
  String get enterTimeWarn =>
      'Per favore inserisci un tempo o i punti Aqua da calcolare!';

  @override
  String get splitsInfo =>
      'Se clicchi sulla casella del record del mondo vedrai i passaggi.';

  @override
  String get limitsInfo =>
      'I limiti seguono le normative di Czech Aquatics. Quando sono indicate due volte, rappresentano i limiti A e B, con i limiti B validi solo per i nuotatori nati nel 2005 (2006) o successivamente.';

  @override
  String get calcualteTooltip => 'Calcolo dei punti Aqua dal tempo.';

  @override
  String get clearTooltip => 'Cancella tutti i campi.';

  @override
  String get rateApp => 'Valuta l\'app';

  @override
  String recordUpdated(String date) {
    return 'Records aggiornati al: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Valido per la stagione: inverno $date';
  }
}
