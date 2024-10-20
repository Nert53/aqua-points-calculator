import 'dart:convert';
import 'package:fina_points_calculator/model/record_data.dart';
import 'package:fina_points_calculator/utils/locale_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  void initState() {
    _getRecords(
        'assets/wr_times/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase()}.json');
    super.initState();
  }

  Future<List<RecordData>> _getRecords(String path) async {
    List<RecordData> records =
        (json.decode(await rootBundle.loadString(path)) as List)
            .map((record) => RecordData.fromJson(record))
            .toList();

    return records;
  }

  void reloadRecords() {
    setState(() {
      _getRecords(
          'assets/wr_times/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase()}.json');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.recordUpdated('20. 10. 2024'),
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Row(
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
                          label: getLocalizedGender(context, gender.name),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
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
          Divider(
            thickness: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(
            child: SelectionArea(
              child: FutureBuilder<List<RecordData>>(
                future: _getRecords(
                    'assets/wr_times/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase().substring(0, 3)}.json'),
                builder: (context, model) {
                  if (model.data?.isNotEmpty ?? false) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: model.data!.length,
                      itemBuilder: (context, index) {
                        var record = model.data![index];
                        var splitLength = 50;
                        if (record.split25) {
                          splitLength = 25;
                        }

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    '${record.event} Splits',
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
                            title: Text('${record.event} - ${record.time}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${record.athlete} (${record.nationality})'),
                                Text(record.competition),
                                Text(
                                    '${record.date} \u2022 ${record.locationCity}, ${record.locationCountry}'),
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
