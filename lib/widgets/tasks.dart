import 'package:flutter/material.dart';
import 'package:rho/widgets/task_tile.dart';
import 'package:rho/helpers/task.dart';

class Tasks extends StatelessWidget {
  final List<Task> tasks;
  final GlobalKey<SliverAnimatedListState> listKey;

  const Tasks({
    Key? key,
    required this.tasks,
    required this.listKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        return SizeTransition(
          axisAlignment: -1.0,
          sizeFactor: animation,
          child: Container(
            margin:
                EdgeInsets.only(bottom: index < tasks.length - 1 ? 16.0 : 0.0),
            child: TaskTile(
              task: tasks[index],
            ),
          ),
        );
      },
      initialItemCount: tasks.length,
    );
  }
}
