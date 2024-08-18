import 'dart:convert';
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
        'assets/data/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase().substring(0, 3)}.json');
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
          'assets/data/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase().substring(0, 3)}.json');
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
            Text(AppLocalizations.of(context)!.recordUpdated('14. 07. 2024'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownMenu(
                initialSelection: Gender.men,
                label: Text(
                  AppLocalizations.of(context)!.gender,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                width: 150,
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
                    label: gender.name,
                  );
                }).toList(),
              ),
              DropdownMenu(
                initialSelection: Course.lcm,
                label: Text(AppLocalizations.of(context)!.course,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                width: 150,
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
                    label: course.value,
                  );
                }).toList(),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(
            child: SelectionArea(
              child: FutureBuilder<List<RecordData>>(
                future: _getRecords(
                    'assets/data/${selectedGender!.name.toLowerCase()}_${selectedCourse!.value.toLowerCase().substring(0, 3)}.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${snapshot.data![index].event} - ${snapshot.data![index].time}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${snapshot.data![index].athlete} (${snapshot.data![index].nationality})'),
                              Text(snapshot.data![index].competition),
                              Text(
                                  '${snapshot.data![index].date} ▪ ${snapshot.data![index].locationCountry}'),
                            ],
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
