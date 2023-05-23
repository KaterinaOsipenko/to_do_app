import 'package:flutter/material.dart';

class TypeButtons extends StatefulWidget {
  const TypeButtons({super.key});

  @override
  State<TypeButtons> createState() => _TypeButtonsState();
}

class _TypeButtonsState extends State<TypeButtons> {
  final List<bool> _selectedTypeToDoItem = [true, false, false];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const List<String> typeToDoItem = [
      'Усі',
      'Робочі',
      'Особисті',
    ];

    void changeButton(int index) {
      setState(() {
        for (int i = 0; i < _selectedTypeToDoItem.length; i++) {
          _selectedTypeToDoItem[i] = i == index;
        }
      });
    }

    return Container(
      margin: EdgeInsets.only(top: mediaQuery.size.height * 0.05),
      child: ToggleButtons(
        isSelected: _selectedTypeToDoItem,
        onPressed: changeButton,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        renderBorder: false,
        children: List<Widget>.generate(
          typeToDoItem.length,
          (index) => Container(
            margin: EdgeInsets.symmetric(
              horizontal: mediaQuery.size.width * 0.02,
            ),
            decoration: BoxDecoration(
              color: _selectedTypeToDoItem[index]
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            width: mediaQuery.size.width * 0.25,
            height: mediaQuery.size.height * 0.06,
            alignment: Alignment.center,
            child: Text(
              typeToDoItem[index],
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          growable: false,
        ),
      ),
    );
  }
}
