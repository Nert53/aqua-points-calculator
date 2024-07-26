import 'package:fina_points_calculator/screens/calculator_screen.dart';
import 'package:fina_points_calculator/screens/records_screen.dart';
import 'package:fina_points_calculator/screens/settings_screen.dart';
import 'package:flutter/material.dart';

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
                height: 70,
                selectedIndex: _selectedIndex,
                onDestinationSelected: _selectScreen,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.calculate_outlined),
                    selectedIcon: Icon(Icons.calculate),
                    label: 'Calculator',
                    tooltip: 'Opens calculator.',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.view_list_outlined),
                    selectedIcon: Icon(Icons.view_list),
                    label: 'Records',
                    tooltip: 'Opens world records list.',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings',
                    tooltip: 'Opens settings.',
                  ),
                ],
              )
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width > 800)
              NavigationRail(
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.calculate_outlined),
                    selectedIcon: Icon(Icons.calculate),
                    label: Text('Calculator'),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.view_list_outlined),
                      label: Text('Records'),
                      selectedIcon: Icon(Icons.view_list)),
                  NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      label: Text('Settings'),
                      selectedIcon: Icon(Icons.settings)),
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: _selectScreen,
                extended: extendedNaviagtionRail,
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
