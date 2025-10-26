import 'dart:convert';
import 'package:fina_points_calculator/model/limit_model.dart';
import 'package:fina_points_calculator/utils/locale_func.dart';
import 'package:fina_points_calculator/utils/points_func.dart';
import 'package:fina_points_calculator/view/widget/feature_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum Competition {
  lublin2025('Lublin 2025', 2025, 'scm', 'europe', 'Lublin'),
  paris2026('Paris 2026', 2026, 'lcm', 'europe', 'Paris');

  const Competition(
      this.displayName, this.year, this.course, this.type, this.city);
  final String displayName;
  final int year;
  final String course;
  final String type;
  final String city;
}

class LimitsScreen extends StatefulWidget {
  const LimitsScreen({super.key});

  @override
  State<LimitsScreen> createState() => _LimitsScreenState();
}

class _LimitsScreenState extends State<LimitsScreen> {
  Competition selectedCompetition = Competition.values.first;
  // Track which limit is currently being long pressed
  int? currentlyLongPressed;
  bool longPressActive = false;
  bool displayNewFeatureBanner = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      var limitLongPressFeatureCount =
          prefs.getInt('limitLongPressFeature') ?? 0;
      if (limitLongPressFeatureCount < 3) {
        showDialog(
            context: context,
            builder: (context) {
              return FeatureDialog(
                  prefs: prefs,
                  limitLongPressFeatureCount: limitLongPressFeatureCount);
            });
      }

      _getLimits(
          'assets/limit_times/${selectedCompetition.type}_${selectedCompetition.course}_${selectedCompetition.year}.json');
    });
  }

  Future<List<List<Limit>>> _getLimits(String path) async {
    List<Limit> limits =
        (json.decode(await rootBundle.loadString(path)) as List)
            .map((limit) => Limit.fromJson(limit))
            .toList();

    var womenLimits = limits
        .where(
          (l) => l.gender == 'women',
        )
        .toList();

    var menLimits = limits
        .where(
          (l) => l.gender == 'men',
        )
        .toList();

    var mixedLimits = limits
        .where(
          (l) => l.gender == 'mixed',
        )
        .toList();

    // Calculate points for each limit
    for (var limit in limits) {
      limit.pointsA = await calculatePoints(limit.timeA, limit.gender,
          selectedCompetition.course, limit.eventDistance, limit.eventStroke);
      limit.pointsB = await calculatePoints(limit.timeB, limit.gender,
          selectedCompetition.course, limit.eventDistance, limit.eventStroke);
    }

    // individual disciplines + one gender realys
    List<List<Limit>> separetedLimits = [];
    for (int i = 0; i < womenLimits.length; i++) {
      separetedLimits.add([menLimits[i], womenLimits[i]]);
    }

    // mixed relays
    for (int i = 0; i < mixedLimits.length; i++) {
      separetedLimits.add([mixedLimits[i], mixedLimits[i]]);
    }

    return separetedLimits;
  }

  void _changeCompetition(Competition competition) {
    setState(() {
      selectedCompetition = competition;
      currentlyLongPressed = null;
      _getLimits(
          'assets/limit_times/${selectedCompetition.type}_${selectedCompetition.course}_${selectedCompetition.year}.json');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<Competition>(
              segments: Competition.values
                  .map((competition) => ButtonSegment<Competition>(
                        value: competition,
                        label: Text(competition.displayName),
                      ))
                  .toList(),
              selected: {selectedCompetition},
              onSelectionChanged: (Set<Competition> newSelection) {
                _changeCompetition(newSelection.first);
              },
            )
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Divider(
          thickness: 2,
        ),
        Row(children: [
          Expanded(
            child: Center(
                child: Text(AppLocalizations.of(context)!.men,
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.discipline,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.women,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
        Divider(),
        Expanded(
          child: FutureBuilder(
              future: _getLimits(
                  'assets/limit_times/${selectedCompetition.type}_${selectedCompetition.course}_${selectedCompetition.year}.json'),
              builder: (context, model) {
                if (model.connectionState == ConnectionState.waiting) {
                  return Skeletonizer(
                      child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('02:02.02'),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Center(
                                child: Text(
                                  '200m Breaststroke',
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('02:02.02'),
                                  ]),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
                } else {
                  return ListView.separated(
                    itemCount: model.data!.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      List<Limit> currentLimit = model.data![index];
                      String discipline =
                          '${currentLimit[0].eventDistance} ${getLocalizedStroke(context, currentLimit[0].eventStroke)}';
                      Limit menLimit = currentLimit[0];
                      Limit womenLimit = currentLimit[1];

                      return GestureDetector(
                        onLongPressStart: (_) {
                          setState(() {
                            currentlyLongPressed = index;
                            longPressActive = true;
                          });
                        },
                        onLongPressCancel: () {
                          setState(() {
                            currentlyLongPressed = null;
                            longPressActive = false;
                          });
                        },
                        child: Opacity(
                          opacity: longPressActive &&
                                  currentlyLongPressed != null &&
                                  currentlyLongPressed != index
                              ? 0.3
                              : 1.0,
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentlyLongPressed == index
                                            ? "${menLimit.pointsA}"
                                            : menLimit.timeA.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      menLimit.timeB.isEmpty
                                          ? SizedBox()
                                          : Text(
                                              currentlyLongPressed == index
                                                  ? "${menLimit.pointsB}"
                                                  : menLimit.timeB.toString(),
                                            ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Center(
                                    child: Text(
                                      menLimit == womenLimit
                                          ? '$discipline ${AppLocalizations.of(context)!.mixed}'
                                          : discipline,
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        currentlyLongPressed == index
                                            ? "${womenLimit.pointsA}"
                                            : womenLimit.timeA.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      womenLimit.timeB.isEmpty
                                          ? SizedBox()
                                          : Text(
                                              currentlyLongPressed == index
                                                  ? "${womenLimit.pointsB}"
                                                  : womenLimit.timeB.toString(),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ],
    );
  }
}
