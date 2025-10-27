import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LimitsSkeleton extends StatelessWidget {
  const LimitsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
