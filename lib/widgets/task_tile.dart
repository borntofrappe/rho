import 'package:flutter/material.dart';
import 'package:rho/helpers/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        onTap: () {
          print('This is where you\'d edit the task');
        },
        onLongPress: () {
          print('This is where you\'d select the task, possibly to delete');
        },
        leading: task.completed
            ? GestureDetector(
                onTap: () {
                  print('This is where you\'d un-check the task');
                },
                child: const Icon(
                  Icons.check_box_rounded,
                  color: Colors.amber,
                ),
              )
            : GestureDetector(
                onTap: () {
                  print('This is where you\'d check the task');
                },
                child: const Icon(
                  Icons.check_box_outline_blank_rounded,
                  color: Colors.black38,
                ),
              ),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: task.completed ? Colors.black45 : Colors.black87,
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
