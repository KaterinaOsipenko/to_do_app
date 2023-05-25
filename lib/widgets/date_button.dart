import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/container_template.dart';

class DateButton extends StatefulWidget {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
  }

  DateButton({super.key});

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  void showFinishDatePicker() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
          DateTime.now().year + 1,
        ),
      ).then(
        (pickedDate) {
          if (pickedDate == null) {
            return;
          }
          setState(() {
            widget._selectedDate = pickedDate;
          });
        },
      );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ContainerTemplate(
      width: mediaQuery.size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Дата завершення: ${DateFormat.yMd().format(widget._selectedDate)}',
              ),
            ],
          ),
          FilledButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.onSecondary)),
            onPressed: showFinishDatePicker,
            child: const Text('Оберіть дату'),
          ),
        ],
      ),
    );
  }
}
