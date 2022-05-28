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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) => TaskTile(
        task: tasks[index],
      ),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 16.0,
      ),
    );
  }
}
