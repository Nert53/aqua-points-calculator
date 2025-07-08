// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get calculate => 'Vypočítat';

  @override
  String get calculator => 'Kalkulačka';

  @override
  String get records => 'Rekordy';

  @override
  String get settings => 'Nastavení';

  @override
  String get length => 'Vzdálenost';

  @override
  String get stroke => 'Způsob';

  @override
  String get splits => 'mezičasy';

  @override
  String get discipline => 'Disciplína';

  @override
  String get limits => 'Limity';

  @override
  String get limitsText => '1) Mistrovství světa a Olympijské hry - Limity jsou převzaty z oficiálních stránek World Aquatics. Pro některé země mohou být limity odlišné (obvykle přísnější). \n\n2) Mistrovství Evropy a Univerziáda - Limity platí pro Český svaz, pro jiné federace budou limity jiné. Česká kritéria jsou založena na 16. nebo 8. místě na nejlepších třech posledních evropských šampionátech nebo na poslední Univerziádě.';

  @override
  String get men => 'Muži';

  @override
  String get women => 'Ženy';

  @override
  String get mixed => 'Mix';

  @override
  String get aquaPoints => 'Aqua Body';

  @override
  String get gender => 'Pohlaví';

  @override
  String get course => 'Bazén';

  @override
  String get language => 'Jazyk';

  @override
  String get colorTheme => 'Barevný režim';

  @override
  String get system => 'Systémový';

  @override
  String get light => 'Světlý';

  @override
  String get dark => 'Tmavý';

  @override
  String get aboutApp => 'O aplikaci';

  @override
  String get close => 'Zavřít';

  @override
  String get lcm => '50m bazén';

  @override
  String get scm => '25m bazén';

  @override
  String get season => 'Sezóna';

  @override
  String get min => 'min';

  @override
  String get sec => 'sek';

  @override
  String get hun => 'set';

  @override
  String get freestyle => 'Volný způsob';

  @override
  String get backstroke => 'Znak';

  @override
  String get butterfly => 'Motýlek';

  @override
  String get breaststroke => 'Prsa';

  @override
  String get medley => 'Polohový závod';

  @override
  String get january => 'Leden';

  @override
  String get february => 'Únor';

  @override
  String get march => 'Březen';

  @override
  String get april => 'Duben';

  @override
  String get may => 'Květen';

  @override
  String get june => 'Červen';

  @override
  String get july => 'Červenec';

  @override
  String get august => 'Srpen';

  @override
  String get september => 'Září';

  @override
  String get october => 'Říjen';

  @override
  String get november => 'Listopad';

  @override
  String get december => 'Prosinec';

  @override
  String get pointsSeason => 'Sezóny pro výpočet bodů';

  @override
  String get pointsSeasonText => 'Protože některé federace používají starší tabulky bodů pro své vlastní účely, přidali jsme možnost si je vybrat. Pro ty kteří nejsou s těmito pojmy obeznámeni, to vysvětlíme. \n\nNapříklad možnost \'sezóna 24/25\' znamená, že body jsou počítány podle tabulek vydaných dne 1. 9. 2024 pro krátký bazén a 1. 1. 2025 pro dlouhý bazén. Tabulky jsou platné po dobu jednoho roku od data vydání. \n\nPokud začíná nová zimní sezóna (krátký bazén) a ještě nejsou k dispozici nové tabulky pro letní sezónu (dlouhý bazén), použijí se poslední letní tabulky.';

  @override
  String get disciplineNotExist => 'Zvolená disciplína neexistuje!';

  @override
  String get enterTimeWarn => 'Prosím zadejte čas/body pro výpočet!';

  @override
  String get splitsInfo => 'Pokud kliknete na dlaždici světového rekordu, zobrazí se vám mezičasy.';

  @override
  String get calcualteTooltip => 'Vypočítá Aqua Body z času.';

  @override
  String get clearTooltip => 'Vynuluje všechna políčka.';

  @override
  String get rateApp => 'Ohodnoť aplikaci';

  @override
  String recordUpdated(String date) {
    return 'Rekordy aktualizovány: $date';
  }

  @override
  String tablesUpdated(String date) {
    return 'Platnost pro sezónu: $date';
  }
}
