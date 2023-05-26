import 'package:flutter/material.dart';

import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/models/status.dart';

import 'package:intl/intl.dart';

import 'package:to_do_app/services/api.dart';

class ToDoItem extends StatefulWidget {
  final ToDo toDo;
  const ToDoItem({
    super.key,
    required this.toDo,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    void onChangeStatus(bool? value) async {
      var response = await ApiSerivce.updateStatus(
          widget.toDo.taskId, widget.toDo.status.number);

      if (response.statusCode != 200) {
        ErrorWidget(response.statusCode);
      } else {
        setState(() {
          widget.toDo.status = (value == true) ? Status.active : Status.done;
        });
      }
    }

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
            onChanged: onChangeStatus,
          ),
        ),
      ),
    );
  }
}
