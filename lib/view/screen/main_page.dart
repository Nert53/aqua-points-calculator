import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _selectScreen(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    bool displayNavigationRail = MediaQuery.of(context).size.width > 800
        ? true
        : false; // navigation bar will appear on wide screens instead of bottom bar
    bool extendedNaviagtionRail = MediaQuery.of(context).size.width > 1200
        ? true
        : false; // extended nav rail will appear only on REALLY wide screens (pc, laptops)

    return Scaffold(
        appBar: AppBar(
          title: const Text('Aqua Points Calculator'),
          actions: [
            if (widget.navigationShell.currentIndex == 1)
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    content: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                            child: Text(
                          AppLocalizations.of(context)!.splitsInfo,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                        )),
                      ],
                    ),
                  ));
                },
              ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          centerTitle: displayNavigationRail ? false : true,
        ),
        bottomNavigationBar: !displayNavigationRail
            ? NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
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
                      icon: Icon(Icons.timer_outlined),
                      selectedIcon: Icon(Icons.timer),
                      label: AppLocalizations.of(context)!.limits,
                      tooltip: 'Opens limits for worlds.'),
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
            if (displayNavigationRail)
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
                      icon: Icon(Icons.timer_outlined),
                      selectedIcon: Icon(Icons.timer),
                      label: Text(AppLocalizations.of(context)!.limits)),
                  NavigationRailDestination(
                      icon: const Icon(Icons.settings_outlined),
                      label: Text(AppLocalizations.of(context)!.settings),
                      selectedIcon: const Icon(Icons.settings)),
                ],
                selectedIndex: widget.navigationShell.currentIndex,
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
              ),
            Expanded(
              child: widget.navigationShell,
            )
          ],
        ));
  }
}
