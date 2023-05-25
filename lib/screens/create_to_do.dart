import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/models/status.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/screens/to_do_list.dart';
import 'package:to_do_app/services/api.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/widgets/input_template.dart';

import 'package:to_do_app/widgets/type_button.dart';
import 'package:to_do_app/widgets/urgent_button.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  late String name;
  late String description;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введіть всі поля!')),
      );
    }
    return null;
  }

  void submitData() async {
    if (_formKey.currentState!.validate() &&
        _formKey2.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey2.currentState!.save();
      ToDo toDo = ToDo(
        taskId: Random(45).toString(),
        status: Status.active,
        name: name,
        type: TypeButton().type,
        description: description,
        file: 'file',
        finishDate: selectedDate,
        urgent: UrgentButton().urgent,
        syncTime: DateTime.now(),
      );
      await ApiSerivce.createToDo(toDo);
      print('dfdfvdv');
      checkUpList();
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Введіть всі поля!')),
      // );
    }
  }

  void checkUpList() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ToDoList()));
  }

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
            selectedDate = pickedDate;
          });
        },
      );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            const Background(),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: mediaQuery.size.width * 0.05),
                            child: BackButton(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.8,
                            child: TextFormField(
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              style: Theme.of(context).textTheme.titleMedium,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Назва завдання...',
                              ),
                              validator: textValidator,
                              onSaved: (value) {
                                name = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.surface,
                          width: mediaQuery.size.width,
                          child: TypeButton(),
                        ),
                        Form(
                          key: _formKey2,
                          child: Container(
                            color: Theme.of(context).colorScheme.surface,
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.size.width * 0.07,
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: mediaQuery.size.height * 0.01),
                            height: mediaQuery.size.height * 0.1,
                            child: TextFormField(
                              cursorColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              validator: textValidator,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.titleSmall,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Додати опис....',
                              ),
                              onSaved: (value) {
                                description = value!;
                              },
                            ),
                          ),
                        ),
                        InputTemplate(
                          width: mediaQuery.size.width,
                          child: Text('Прикріпити файл',
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                        InputTemplate(
                          width: mediaQuery.size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Дата завершення: ${DateFormat.yMd().format(selectedDate)}',
                                  ),
                                ],
                              ),
                              FilledButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                onPressed: showFinishDatePicker,
                                child: const Text('Оберіть дату'),
                              ),
                            ],
                          ),
                        ),
                        UrgentButton(),
                        FilledButton(
                          onPressed: submitData,
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.tertiary),
                          ),
                          child: Text(
                            'Створити',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
