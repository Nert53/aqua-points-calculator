import 'dart:convert';
import 'package:fina_points_calculator/model/limit_model.dart';
import 'package:fina_points_calculator/utils/locale_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fina_points_calculator/l10n/app_localizations.dart';

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

  @override
  void initState() {
    _getLimits(
        'assets/limit_times/${selectedCompetition.type}_${selectedCompetition.course}_${selectedCompetition.year}.json');
    super.initState();
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

    List<List<Limit>> separetedLimits = [];
    for (int i = 0; i < womenLimits.length; i++) {
      separetedLimits.add([menLimits[i], womenLimits[i]]);
    }

    return separetedLimits;
  }

  _changeCompetition(Competition competition) {
    setState(() {
      selectedCompetition = competition;
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
                if (model.data?.isNotEmpty ?? false) {
                  return ListView.separated(
                      itemCount: model.data!.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        List<Limit> currentLimit = model.data![index];
                        String discipline =
                            '${currentLimit[0].eventDistance} ${getLocalizedStroke(context, currentLimit[0].eventStroke)}';
                        Limit menLimit = currentLimit[0];
                        Limit womenLimit = currentLimit[1];

                        return SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      menLimit.timeA.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (menLimit.timeB.isNotEmpty)
                                      Text(menLimit.timeB.toString()),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Center(
                                  child: Text(
                                    discipline,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      womenLimit.timeA.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (womenLimit.timeB.isNotEmpty)
                                      Text(womenLimit.timeB.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
