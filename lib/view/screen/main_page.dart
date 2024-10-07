import 'package:fina_points_calculator/view/screen/calculator_screen.dart';
import 'package:fina_points_calculator/view/screen/records_screen.dart';
import 'package:fina_points_calculator/view/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = <Widget>[
    const CalculatorScreen(),
    const RecordsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool extendedNaviagtionRail = MediaQuery.of(context).size.width > 1200
        ? true
        : false; // extended nav rail will appear only on realy wide screens (pc, laptops)

    return Scaffold(
        appBar: AppBar(
          title: const Text('Aqua Points Calculator'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 800
            ? NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _selectScreen,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.calculate_outlined),
                    selectedIcon: const Icon(Icons.calculate),
                    label: AppLocalizations.of(context)!.calculator,
                    tooltip: 'Opens calculator.',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.view_list_outlined),
                    selectedIcon: const Icon(Icons.view_list),
                    label: AppLocalizations.of(context)!.records,
                    tooltip: 'Opens world records list.',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    label: AppLocalizations.of(context)!.settings,
                    tooltip: 'Opens settings.',
                  ),
                ],
              )
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width > 800)
              NavigationRail(
                destinations: [
                  NavigationRailDestination(
                    icon: const Icon(Icons.calculate_outlined),
                    selectedIcon: const Icon(Icons.calculate),
                    label: Text(AppLocalizations.of(context)!.calculator),
                  ),
                  NavigationRailDestination(
                      icon: const Icon(Icons.view_list_outlined),
                      label: Text(AppLocalizations.of(context)!.records),
                      selectedIcon: const Icon(Icons.view_list)),
                  NavigationRailDestination(
                      icon: const Icon(Icons.settings_outlined),
                      label: Text(AppLocalizations.of(context)!.settings),
                      selectedIcon: const Icon(Icons.settings)),
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: _selectScreen,
                extended: extendedNaviagtionRail,
                minWidth: 96,
                labelType: extendedNaviagtionRail
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                selectedLabelTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                // same color as background of bottom nav bar
              ),
            Expanded(
              child: _screens[_selectedIndex],
            )
          ],
        ));
  }
}
