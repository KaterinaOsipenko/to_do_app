import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_app/models/status.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/screens/to_do_list.dart';
import 'package:to_do_app/services/api.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/widgets/container_template.dart';

import 'package:to_do_app/widgets/buttons/type_button.dart';
import 'package:to_do_app/widgets/buttons/urgent_button.dart';
import 'package:to_do_app/widgets/date_button.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String name;
  String description = '';

  String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введіть назву!')),
      );
    }
    return null;
  }

  void submitData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ToDo toDo = ToDo(
        taskId: Random(45).toString(),
        status: Status.active,
        name: name,
        type: TypeButton().type,
        description: description,
        file: 'file',
        finishDate: DateButton().selectedDate,
        urgent: UrgentButton().urgent,
        syncTime: DateTime.now(),
      );
      await ApiSerivce.createToDo(toDo);

      checkUpList();
    }
  }

  void checkUpList() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ToDoList()));
  }

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
                        ContainerTemplate(
                          width: mediaQuery.size.width,
                          child: Text('Прикріпити файл',
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                        DateButton(),
                        UrgentButton(),
                        FilledButton(
                          onPressed: submitData,
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.tertiary),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                horizontal: mediaQuery.size.width * 0.1,
                                vertical: mediaQuery.size.height * 0.02,
                              ),
                            ),
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
