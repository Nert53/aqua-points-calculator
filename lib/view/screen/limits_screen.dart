import 'dart:convert';

import 'package:fina_points_calculator/model/limit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LimitsScreen extends StatefulWidget {
  const LimitsScreen({super.key});

  @override
  State<LimitsScreen> createState() => _LimitsScreenState();
}

class _LimitsScreenState extends State<LimitsScreen> {
  String selectedCourse = 'course';
  String selectedYear = 'year';

  @override
  void initState() {
    _getLimits('assets/limit_times/world_scm_2024.json');
    super.initState();
  }

  Future<List<Limit>> _getLimits(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = json.decode(response);

    var t = response.length;

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Worlds Limits'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      body: FutureBuilder(
          future: _getLimits('assets/limit_times/world_scm_2024.json'),
          builder: (context, model) {
            if (model.data!.isNotEmpty) {
              return ListView.separated(
                  itemCount: model.data!.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(model.data![index].time.toString()),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
