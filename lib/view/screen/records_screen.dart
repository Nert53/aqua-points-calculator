import 'dart:convert';
import 'package:fina_points_calculator/model/world_record_model.dart';
import 'package:fina_points_calculator/utils/constants.dart';
import 'package:fina_points_calculator/utils/locale_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fina_points_calculator/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fina_points_calculator/utils/shared_preference_service.dart';
import 'package:fina_points_calculator/utils/junior_mode_notifier.dart';

enum Gender {
  men('Men', Icons.male_outlined),
  women('Women', Icons.female_outlined),
  mixed('Mixed', Icons.circle_outlined);

  const Gender(this.name, this.icon);
  final String name;
  final IconData icon;
}

enum Course {
  lcm('lcm', 'LCM (50m)'),
  scm('scm', 'SCM (25m)');

  const Course(this.value, this.name);
  final String value;
  final String name;
}

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final TextEditingController genderController = TextEditingController();
  Gender? selectedGender = Gender.men;
  final TextEditingController courseController = TextEditingController();
  Course? selectedCourse = Course.lcm;
  late JuniorModeNotifier _juniorModeNotifier;

  @override
  void initState() {
    _juniorModeNotifier = JuniorModeNotifier();
    _juniorModeNotifier.addListener(_onJuniorModeChanged);
    if (PreferencesService.isJuniorMode()) {
      _getRecords(
          'assets/wr_times/juniors/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase()}_junior.json');
    } else {
      _getRecords(
          'assets/wr_times/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase()}.json');
    }
    super.initState();
  }

  void _onJuniorModeChanged() {
    reloadRecords();
  }

  @override
  void dispose() {
    _juniorModeNotifier.removeListener(_onJuniorModeChanged);
    genderController.dispose();
    courseController.dispose();
    super.dispose();
  }

  Future<List<WorldRecord>> _getRecords(String path) async {
    List<WorldRecord> records =
        (json.decode(await rootBundle.loadString(path)) as List)
            .map((record) => WorldRecord.fromJson(record))
            .toList();

    return records;
  }

  void reloadRecords() {
    if (PreferencesService.isJuniorMode()) {
      setState(() {
        _getRecords(
            'assets/wr_times/juniors/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase()}_junior.json');
      });
    } else {
      setState(() {
        _getRecords(
            'assets/wr_times/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase()}.json');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                AppLocalizations.of(context)!.recordUpdated(
                    PreferencesService.isJuniorMode()
                        ? lastJuniorRecordUpdateDate
                        : lastRecordUpdateDate),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                )),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.zero,
                      initialSelection: Gender.men,
                      label: Text(
                        AppLocalizations.of(context)!.gender,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      width: 150,
                      inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                      menuStyle: MenuStyle(
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))))),
                      controller: genderController,
                      onSelected: (Gender? gender) {
                        setState(() {
                          selectedGender = gender;
                          reloadRecords();
                        });
                      },
                      dropdownMenuEntries: Gender.values
                          .map<DropdownMenuEntry<Gender>>((Gender gender) {
                        return DropdownMenuEntry<Gender>(
                          value: gender,
                          label: getLocalizedGender(context, gender.name,
                              PreferencesService.isJuniorMode()),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownMenu(
                      expandedInsets: EdgeInsets.zero,
                      initialSelection: Course.lcm,
                      label: Text(AppLocalizations.of(context)!.course,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                      width: 150,
                      inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                      menuStyle: MenuStyle(
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))))),
                      controller: courseController,
                      onSelected: (Course? course) {
                        setState(() {
                          selectedCourse = course;
                        });
                      },
                      dropdownMenuEntries: Course.values
                          .map<DropdownMenuEntry<Course>>((Course course) {
                        return DropdownMenuEntry<Course>(
                            value: course,
                            label: getLocalizedCourse(
                              context,
                              course.value,
                            ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            child: SelectionArea(
              child: FutureBuilder<List<WorldRecord>>(
                future: _getRecords(PreferencesService.isJuniorMode()
                    ? 'assets/wr_times/juniors/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase()}_junior.json'
                    : 'assets/wr_times/${selectedGender!.name.toLowerCase().replaceAll(' ', '_')}_${selectedCourse!.value.toLowerCase().substring(0, 3)}.json'),
                builder: (context, model) {
                  if (model.data?.isNotEmpty ?? false) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        WorldRecord record = model.data![index];
                        int splitLength = 50;
                        if (record.split25) {
                          splitLength = 25;
                        }

                        String recordGender = getLocalizedGender(
                            context,
                            record.event.split(' ')[0],
                            PreferencesService.isJuniorMode());
                        String recordStroke =
                            getLocalizedStroke(context, record.eventStroke);
                        String recordDistance = record.eventDistance;

                        String recordDateDay = record.date.split(' ')[0];
                        String recordDateMonth = getLocalizedMonth(
                            context, record.date.split(' ')[1]);
                        String recordDateYear = record.date.split(' ')[2];

                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      '$recordGender $recordDistance $recordStroke ${AppLocalizations.of(context)!.splits}',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.close,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                      ),
                                    ],
                                    content: SizedBox(
                                      height: (record.splits.length * 50) + 15,
                                      width: double.minPositive,
                                      child: ListView.builder(
                                          itemCount: record.splits.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                  '${(index + 1) * splitLength}m - ${record.splits[index]} (${record.sectionTimes[index]})'),
                                            );
                                          }),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Text(
                                  '$recordGender $recordDistance $recordStroke - ${record.time}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${record.athlete} (${record.nationality})'),
                                  Text(record.competition),
                                  Text(
                                      '$recordDateDay ${recordDateMonth.toLowerCase()} $recordDateYear  \u2022 ${record.locationCity}, ${record.locationCountry}'),
                                ],
                              ),
                              trailing: record.isNew
                                  ? SvgPicture.asset(
                                      'assets/icons/new.svg',
                                      width: 18,
                                      height: 18,
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
