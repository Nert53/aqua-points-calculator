import 'dart:convert';
import 'dart:math';
import 'package:fina_points_calculator/model/record_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Gender {
  men('Men', Icons.male_outlined, Color.fromARGB(255, 8, 62, 156)),
  women('Women', Icons.female_outlined, Color.fromARGB(255, 206, 24, 24)),
  mixed('Mixed', Icons.circle_outlined, Color.fromARGB(255, 34, 34, 34));

  const Gender(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

enum Course {
  lcm('LCM (50m)'),
  scm('SCM (25m)');

  const Course(this.value);
  final String value;
}

enum Distance {
  fifty('50m'),
  hundred('100m'),
  twoHundred('200m'),
  fourHundred('400m'),
  eightHundred('800m'),
  fifteenHundred('1500m');

  const Distance(this.length);
  final String length;
}

enum Stroke {
  free('Freestyle'),
  back('Backstroke'),
  breast('Breaststroke'),
  fly('Butterfly'),
  im('Medley');

  const Stroke(this.name);
  final String name;
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool lastEditedTime = true;
  bool lastEditedPoints = false;

  void swapEditedValues(bool time) {
    if (time) {
      lastEditedTime = true;
      lastEditedPoints = false;
    } else {
      lastEditedTime = false;
      lastEditedPoints = true;
    }
  }

  Gender? _gender = Gender.men;
  Course? _course = Course.lcm;

  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();
  final _hundredthsController = TextEditingController();
  final _pointsController = TextEditingController();
  final _distanceController = TextEditingController();
  final _strokeController = TextEditingController();

  // main function for both calculations
  void calculate() async {
    // everything empty -> show snackbar with "error"
    if (_minutesController.text.isEmpty &&
        _secondsController.text.isEmpty &&
        _hundredthsController.text.isEmpty &&
        _pointsController.text.isEmpty) {
      SnackBar snackBar = const SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          content: Text('Please enter a time or Aqua Points to calculate!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    // both fields filled (points and time) -> decide by last edited value
    if (_pointsController.text.isNotEmpty &&
            _minutesController.text.isNotEmpty ||
        _secondsController.text.isNotEmpty ||
        _hundredthsController.text.isNotEmpty) {
      if (lastEditedPoints) {
        calculateTime();
        lastEditedPoints = true;
        lastEditedTime = false;
        return;
      } else {
        calculatePoints();
        lastEditedPoints = false;
        lastEditedTime = true;
        return;
      }
    }

    // only time filled -> calculate points
    if (_minutesController.text.isNotEmpty ||
        _secondsController.text.isNotEmpty ||
        _hundredthsController.text.isNotEmpty) {
      calculatePoints();
      lastEditedPoints = false;
      lastEditedTime = true;
      return;
    }

    // only points filled -> calculate time
    calculateTime();
    lastEditedPoints = true;
    lastEditedTime = false;
    return;
  }

  void calculatePoints() async {
    int minutes, seconds, hundredths;
    _minutesController.text.isEmpty
        ? minutes = 0
        : minutes = int.parse(_minutesController.text);
    _secondsController.text.isEmpty
        ? seconds = 0
        : seconds = int.parse(_secondsController.text);
    _hundredthsController.text.isEmpty
        ? hundredths = 0
        : hundredths = int.parse(_hundredthsController.text);

    if (hundredths < 10) {
      hundredths *= 10;
    }

    double overallTimeSeconds = (minutes * 60) + seconds + (hundredths / 100);
    var recordTimeSeconds = await findRecordTime(
        _gender!.name.toLowerCase(),
        _course!.value.toLowerCase(),
        _distanceController.text,
        _strokeController.text.toLowerCase());

    int points =
        (1000 * pow(recordTimeSeconds / overallTimeSeconds, 3)).toInt();

    setState(() {
      _pointsController.text = points.toString();
    });
  }

  void calculateTime() async {
    int points = int.parse(_pointsController.text);
    var recordTimeSeconds = await findRecordTime(
        _gender!.name.toLowerCase(),
        _course!.value.toLowerCase(),
        _distanceController.text,
        _strokeController.text.toLowerCase());

    double timeSecond =
        (recordTimeSeconds / pow(points / 1000, 1 / 3)).toDouble();
    int minutes = timeSecond ~/ 60;
    int seconds = timeSecond.toInt() % 60;
    int hundredths = ((timeSecond - (minutes * 60) - seconds) * 100).toInt();

    setState(() {
      _minutesController.text = minutes.toString();
      _secondsController.text = seconds.toString();
      _hundredthsController.text = hundredths.toString();
    });
  }

  void clearAllControllers() {
    _minutesController.clear();
    _secondsController.clear();
    _hundredthsController.clear();
    _pointsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.tablesUpdated('14. 07. 2024'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400, minWidth: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _pointsController,
                    onChanged: (value) {
                      swapEditedValues(false);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.aquaPoints,
                        prefixIcon: const Icon(Icons.pin_outlined),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        isDense: true),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 180, minWidth: 100),
                        child: DropdownMenu<Distance>(
                          label: Text(AppLocalizations.of(context)!.length,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          width: min(
                              MediaQuery.of(context).size.width * 0.38, 180),
                          controller: _distanceController,
                          initialSelection: Distance.fifty,
                          dropdownMenuEntries: Distance.values
                              .map<DropdownMenuEntry<Distance>>(
                                  (Distance distance) {
                            return DropdownMenuEntry<Distance>(
                                value: distance, label: distance.length);
                          }).toList(),
                        ),
                      ),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 180, minWidth: 100),
                        child: DropdownMenu<Stroke>(
                          label: Text(AppLocalizations.of(context)!.stroke,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          width: min(
                              MediaQuery.of(context).size.width * 0.38, 180),
                          controller: _strokeController,
                          initialSelection: Stroke.free,
                          dropdownMenuEntries: Stroke.values
                              .map<DropdownMenuEntry<Stroke>>((Stroke stroke) {
                            return DropdownMenuEntry<Stroke>(
                                value: stroke, label: stroke.name);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Radio<Gender>(
                              value: Gender.men,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                          Text(AppLocalizations.of(context)!.men)
                        ],
                      ),
                      Column(
                        children: [
                          Radio<Gender>(
                              value: Gender.women,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                          Text(AppLocalizations.of(context)!.women)
                        ],
                      ),
                      const SizedBox(
                        width: 38,
                      ),
                      Column(
                        children: [
                          Radio<Course>(
                              value: Course.lcm,
                              groupValue: _course,
                              onChanged: (Course? value) {
                                setState(() {
                                  _course = value;
                                });
                              }),
                          Text(AppLocalizations.of(context)!.lcm)
                        ],
                      ),
                      Column(
                        children: [
                          Radio<Course>(
                              value: Course.scm,
                              groupValue: _course,
                              onChanged: (Course? value) {
                                setState(() {
                                  _course = value;
                                });
                              }),
                          Text(AppLocalizations.of(context)!.scm)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FloatingActionButton.extended(
                          tooltip: 'Calculate Aqua Points from time.',
                          onPressed: () {
                            calculate();
                          },
                          label: Text(
                            AppLocalizations.of(context)!.calculate,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          //icon: Icon(Icons.arrow_right_outlined),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      FloatingActionButton(
                        tooltip: 'Clear all fields.',
                        onPressed: () {
                          clearAllControllers();
                        },
                        child: const Icon(Icons.delete_sweep_outlined),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                          child: TextField(
                              controller: _minutesController,
                              onChanged: (value) {
                                swapEditedValues(true);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.min,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  isDense: true))),
                      const SizedBox(
                        width: 16,
                        child: Center(
                          child: Text('.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28)),
                        ),
                      ),
                      Flexible(
                          child: TextField(
                              controller: _secondsController,
                              onChanged: (value) {
                                swapEditedValues(true);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.sec,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  isDense: true))),
                      const SizedBox(
                        width: 16,
                        child: Center(
                          child: Text('.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28)),
                        ),
                      ),
                      Flexible(
                          child: TextField(
                              controller: _hundredthsController,
                              onChanged: (value) {
                                swapEditedValues(true);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.hun,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  isDense: true))),
                    ],
                  )
                ],
              ),
            )),
          ),
        ));
  }
}

Future<double> findRecordTime(
    String gender, String course, String distance, String stroke) async {
  var allRecords = await _getRecords(
      'assets/table_base_times/${gender.toLowerCase()}_${course.toLowerCase().substring(0, 3)}.json');
  for (var record in allRecords) {
    if (record.eventDistance == distance && record.eventStroke == stroke) {
      double minutes, seconds, hundredths;
      bool overMinuteRecord = record.time.contains(':');
      var editedTime = record.time.replaceAll(':', '.').split('.');

      if (overMinuteRecord) {
        minutes = double.parse(editedTime[0]);
        seconds = double.parse(editedTime[1]);
        hundredths = double.parse(editedTime[2]);
      } else {
        minutes = 0.0;
        seconds = double.parse(editedTime[0]);
        hundredths = double.parse(editedTime[1]);
      }

      return (minutes * 60) + seconds + (hundredths / 100);
    }
  }

  return 0.0;
}

Future<List<RecordData>> _getRecords(String path) async {
  List<RecordData> records =
      (json.decode(await rootBundle.loadString(path)) as List)
          .map((record) => RecordData.fromJson(record))
          .toList();

  return records;
}
