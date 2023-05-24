import 'package:flutter/material.dart';

import 'package:to_do_app/models/to_do.dart';

import 'package:intl/intl.dart';

class ToDoItem extends StatefulWidget {
  final ToDo toDo;
  final Function onChangeStatus;
  const ToDoItem({super.key, required this.toDo, required this.onChangeStatus});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.005,
        horizontal: mediaQuery.size.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: widget.toDo.urgent.number == 1
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: widget.toDo.type.number == 1
            ? const Icon(
                Icons.work_outline,
              )
            : const Icon(
                Icons.home_outlined,
              ),
        title: Text(
          widget.toDo.name,
          style: Theme.of(context).textTheme.bodySmall!,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.toDo.finishDate),
          style: Theme.of(context).textTheme.labelSmall!,
        ),
        trailing: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.onSecondary)),
          child: Checkbox(
            value: widget.toDo.status.number == 1 ? false : true,
            activeColor: Theme.of(context).colorScheme.surface,
            checkColor: Theme.of(context).colorScheme.onSecondary,
            onChanged: (value) =>
                widget.onChangeStatus(value, widget.toDo.taskId),
          ),
        ),
      ),
    );
  }
}
