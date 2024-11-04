import 'package:flutter/material.dart';

class LimitsScreen extends StatefulWidget{
  const LimitsScreen({super.key});

  @override
  State<LimitsScreen> createState() => _LimitsScreenState();
}

class _LimitsScreenState extends State<LimitsScreen> {
  String selectedCourse = 'course';
  String selectedYear = 'year';

  @override
  void initState() {
    _getLimits('assets/limit_times/world_${selectedCourse}_$selectedYear.json');
    super.initState();
  }

  Future<List> _getLimits(String path) async {
    
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Text('LimitsScreen'),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
        );
      }),
    );
  }
}