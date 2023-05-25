// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:to_do_app/widgets/input_template.dart';

class ChoseDate extends StatefulWidget {
  late DateTime? _selectedDate;

  ChoseDate({super.key});

  DateTime? get selectedDate {
    if (_selectedDate != null) {
      return _selectedDate;
    }
    return null;
  }

  set selectedDate(DateTime? value) {
    _selectedDate = value;
  }

  @override
  State<ChoseDate> createState() => _ChoseDateState();
}

class _ChoseDateState extends State<ChoseDate> {
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
    return InputTemplate(
      width: mediaQuery.size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget._selectedDate == null
                    ? "Дата не обрана"
                    : 'Дата завершення: ${DateFormat.yMd().format(widget._selectedDate!)}',
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
