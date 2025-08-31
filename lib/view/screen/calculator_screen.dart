import 'dart:convert';
import 'dart:math';
import 'package:fina_points_calculator/model/record_model.dart';
import 'package:fina_points_calculator/utils/constants.dart';
import 'package:fina_points_calculator/utils/locale_func.dart';
import 'package:fina_points_calculator/view/widget/time_field.dart';
import 'package:fina_points_calculator/view/widget/warning_snackbar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fina_points_calculator/l10n/app_localizations.dart';

enum Gender {
  men('Men', Icons.male_outlined, Color.fromARGB(255, 8, 62, 156)),
  women('Women', Icons.female_outlined, Color.fromARGB(255, 206, 24, 24)),
  mixed('Mixed', Icons.circle_outlined, Color.fromARGB(255, 34, 34, 34));

  const Gender(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}

enum Season {
  s2526('25/26', '25-26'),
  s2425('24/25', '24-25'),
  s2324('23/24', '23-24'),
  s2223('22/23', '22-23');

  const Season(this.name, this.value);
  final String name;
  final String value;
}

enum Course {
  lcm('LCM (50m)'),
  scm('SCM (25m)');

  const Course(this.namePretty);
  final String namePretty;
}

enum Distance {
  fifty('50 m'),
  hundred('100 m'),
  twoHundred('200 m'),
  fourHundred('400 m'),
  eightHundred('800 m'),
  fifteenHundred('1500 m');

  const Distance(this.lengthPretty);
  final String lengthPretty;
}

enum Stroke {
  free('Freestyle'),
  back('Backstroke'),
  breast('Breaststroke'),
  fly('Butterfly'),
  medley('Medley');

  const Stroke(
    this.name,
  );
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
  Course? _course = Course.scm;

  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();
  final _hundredthsController = TextEditingController();
  final _pointsController = TextEditingController();
  final _distanceController = TextEditingController();
  final _strokeController = TextEditingController();
  final _seasonController = TextEditingController();

  Stroke _selectedStroke = Stroke.free;

  void setSelectedStroke(Stroke stroke) {
    _selectedStroke = stroke;
  }

  // main function for both calculations
  void calculate() async {
    // everything empty -> show snackbar
    if (_minutesController.text.isEmpty &&
        _secondsController.text.isEmpty &&
        _hundredthsController.text.isEmpty &&
        _pointsController.text.isEmpty) {
      showWarningSnackBar(context, AppLocalizations.of(context)!.enterTimeWarn);
      return;
    }

    if (!checkDisciplineCorrectness()) {
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

    // second condition is for enters like 05 or 09 that should be take as 9 hundredths not 90
    if (hundredths < 10 && _hundredthsController.text.length < 2) {
      hundredths *= 10;
    }

    double overallTimeSeconds = (minutes * 60) + seconds + (hundredths / 100);
    var recordTimeSeconds = await findRecordTime(
        _gender!.name.toLowerCase(),
        _course!.name.toLowerCase(),
        _distanceController.text,
        _selectedStroke.name,
        _seasonController.text.replaceAll('/', '-'));

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
        _course!.namePretty.toLowerCase(),
        _distanceController.text,
        _selectedStroke.name,
        _seasonController.text.replaceAll('/', '-'));

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
    // sets all buttons to initial state
    _minutesController.clear();
    _secondsController.clear();
    _hundredthsController.clear();
    _pointsController.clear();
    setState(() {
      _distanceController.text = Distance.fifty.lengthPretty;
      setSelectedStroke(Stroke.free);
      _gender = Gender.men;
      _course = Course.lcm;
      _seasonController.text = Season.s2526.name;
    });
  }

  bool checkDisciplineCorrectness() {
    var warningMessage = AppLocalizations.of(context)!.disciplineNotExist;

    if (_distanceController.text == Distance.eightHundred.lengthPretty ||
        _distanceController.text == Distance.fifteenHundred.lengthPretty) {
      if (_selectedStroke != Stroke.free) {
        showWarningSnackBar(context, warningMessage);
        return false;
      }
    }

    if (_distanceController.text == Distance.fourHundred.lengthPretty) {
      if (!(_selectedStroke == Stroke.free ||
          _selectedStroke == Stroke.medley)) {
        showWarningSnackBar(context, warningMessage);
        return false;
      }
    }

    if (_course == Course.lcm) {
      if (_distanceController.text == Distance.fifty.lengthPretty ||
          _distanceController.text == Distance.hundred.lengthPretty) {
        if (_selectedStroke == Stroke.medley) {
          showWarningSnackBar(context, warningMessage);
          return false;
        }
      }
    }

    if (_course == Course.scm) {
      if (_distanceController.text == Distance.fifty.lengthPretty &&
          _selectedStroke == Stroke.medley) {
        showWarningSnackBar(context, warningMessage);
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _strokeController.text = getLocalizedStroke(context, _selectedStroke.name);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    AppLocalizations.of(context)!
                        .tablesUpdated(lastTableUpdateYear),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Center(
                  child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400, minWidth: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _pointsController,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                swapEditedValues(false);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              decoration: InputDecoration(
                                  label: Text(
                                      AppLocalizations.of(context)!.aquaPoints,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  prefixIcon: const Icon(Icons.pin_outlined),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  isDense: true),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: DropdownMenu<Season>(
                              expandedInsets: EdgeInsets.zero,
                              label: Text(AppLocalizations.of(context)!.season,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              controller: _seasonController,
                              initialSelection: Season.s2526,
                              inputDecorationTheme: const InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                              menuStyle: MenuStyle(
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))))),
                              dropdownMenuEntries: Season.values
                                  .map<DropdownMenuEntry<Season>>(
                                      (Season season) {
                                return DropdownMenuEntry<Season>(
                                    value: season, label: season.name);
                              }).toList(),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownMenu<Distance>(
                            expandedInsets: EdgeInsets.zero,
                            label: Text(AppLocalizations.of(context)!.length,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            controller: _distanceController,
                            initialSelection: Distance.fifty,
                            inputDecorationTheme: const InputDecorationTheme(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            menuStyle: MenuStyle(
                                shape: WidgetStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))))),
                            dropdownMenuEntries: Distance.values
                                .map<DropdownMenuEntry<Distance>>(
                                    (Distance distance) {
                              return DropdownMenuEntry<Distance>(
                                  value: distance,
                                  label: distance.lengthPretty);
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 3,
                          child: DropdownMenu<Stroke>(
                            expandedInsets: EdgeInsets.zero,
                            onSelected: (stroke) {
                              setSelectedStroke(stroke!);
                            },
                            label: Text(AppLocalizations.of(context)!.stroke,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            initialSelection: Stroke.free,
                            controller: _strokeController,
                            inputDecorationTheme: const InputDecorationTheme(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            menuStyle: MenuStyle(
                                shape: WidgetStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))))),
                            dropdownMenuEntries: Stroke.values
                                .map<DropdownMenuEntry<Stroke>>(
                                    (Stroke stroke) {
                              return DropdownMenuEntry<Stroke>(
                                  value: stroke,
                                  label:
                                      getLocalizedStroke(context, stroke.name)
                                          .capitalize());
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
                            tooltip:
                                AppLocalizations.of(context)!.calcualteTooltip,
                            onPressed: () {
                              FirebaseAnalytics.instance.logEvent(
                                  name: 'calculate_button_pressed',
                                  parameters: {
                                    'gender': _gender.toString(),
                                    'course': _course.toString(),
                                  });
                              calculate();
                            },
                            elevation: 2,
                            label: Text(
                              AppLocalizations.of(context)!.calculate,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        FloatingActionButton(
                          tooltip: AppLocalizations.of(context)!.clearTooltip,
                          elevation: 2,
                          onPressed: () {
                            clearAllControllers();
                          },
                          child: const Icon(
                            Icons.delete_sweep_outlined,
                          ),
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
                            child: TimeField(
                                controller: _minutesController,
                                functionOnChanged: swapEditedValues,
                                maxValue: 99,
                                labelText: AppLocalizations.of(context)!.min)),
                        const SizedBox(
                          width: 16,
                          child: Center(
                            child: Text('.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                          ),
                        ),
                        Flexible(
                            child: TimeField(
                                controller: _secondsController,
                                functionOnChanged: swapEditedValues,
                                maxValue: 59,
                                labelText: AppLocalizations.of(context)!.sec)),
                        const SizedBox(
                          width: 16,
                          child: Center(
                            child: Text('.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                          ),
                        ),
                        Flexible(
                            child: TimeField(
                                controller: _hundredthsController,
                                functionOnChanged: swapEditedValues,
                                maxValue: 99,
                                labelText: AppLocalizations.of(context)!.hun)),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          )),
    );
  }
}

Future<double> findRecordTime(String gender, String course, String distance,
    String stroke, String season) async {
  gender = gender.toLowerCase();
  course = course.toLowerCase().substring(0, 3);
  distance = distance.toLowerCase().replaceAll(' ', '');
  stroke = stroke.toLowerCase();

  var allRecords = await _getRecords(
      'assets/table_base_times/$season/${gender}_$course.json');
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

Future<List<Record>> _getRecords(String path) async {
  List<Record> records =
      (json.decode(await rootBundle.loadString(path)) as List)
          .map((record) => Record.fromJson(record))
          .toList();

  return records;
}
