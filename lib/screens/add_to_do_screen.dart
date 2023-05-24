import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/background.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    String? textValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Будь ласка, введіть текст';
      }
      return null;
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
                  TextFormField(
                    initialValue: 'Назва завдання...',
                    decoration: InputDecoration(border: InputBorder.none),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
