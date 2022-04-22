import 'package:flutter/material.dart';
import 'package:rho/helpers/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function handleDelete;
  const TaskList({
    Key? key,
    required this.tasks,
    required this.handleDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) => Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: ListTile(
            minLeadingWidth: 0.0,
            leading: GestureDetector(
              onTap: () {
                handleDelete(index);
              },
              child: const Icon(
                Icons.remove_circle_rounded,
                color: Colors.black38,
              ),
            ),
            title: Text(
              tasks[index].title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 12.0,
        ),
      ),
    );
  }
}
