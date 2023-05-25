import 'package:flutter/material.dart';
import 'package:to_do_app/models/urgent.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/models/type.dart';
import 'package:to_do_app/widgets/type_button.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/widgets/urgent_button.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Type typeItem = Type.work;

    Urgent? urgent = Urgent.no;

    String? textValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Будь ласка, введіть текст';
      }
      return null;
    }

    void _showDatePicker() {
      showDatePicker(
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
            _selectedDate = pickedDate;
          });
        },
      );
    }

    return Scaffold(
      body: Stack(children: [
        const Background(),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: mediaQuery.size.width * 0.05),
                      child: BackButton(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width * 0.8,
                      margin:
                          EdgeInsets.only(left: mediaQuery.size.width * 0.03),
                      child: TextFormField(
                        cursorColor: Theme.of(context).colorScheme.onSecondary,
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Назва завдання...',
                        ),
                        validator: textValidator,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: const TypeButton(),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    margin: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.03,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: mediaQuery.size.width * 0.07,
                    ),
                    height: mediaQuery.size.height * 0.15,
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onSecondary,
                      validator: textValidator,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Додати опис....',
                      ),
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * 0.1,
                    color: Theme.of(context).colorScheme.surface,
                    margin: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.003,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.07,
                        vertical: mediaQuery.size.height * 0.03),
                    child: Text('Прикріпити файл',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Container(
                    width: mediaQuery.size.width,
                    color: Theme.of(context).colorScheme.surface,
                    margin: EdgeInsets.symmetric(
                      vertical: mediaQuery.size.height * 0.005,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.07,
                        vertical: mediaQuery.size.height * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Дата не обрана"
                                  : 'Дата завершення: ${DateFormat.yMd().format(_selectedDate!)}',
                            ),
                          ],
                        ),
                        FilledButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.onSecondary)),
                          onPressed: _showDatePicker,
                          child: const Text('Оберіть дату'),
                        ),
                      ],
                    ),
                  ),
                  UrgentButton(),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
