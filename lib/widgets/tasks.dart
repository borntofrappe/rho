import 'package:flutter/material.dart';
import 'package:rho/widgets/task_tile.dart';
import 'package:rho/helpers/task.dart';

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isEven) {
            return TaskTile(
              task: tasks[index ~/ 2],
            );
          }
          return const SizedBox(
            height: 16.0,
          );
        },
        childCount: (tasks.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          return null;
        },
      ),
    );
  }
}
