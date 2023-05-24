import 'package:flutter/material.dart';

class AddToDoItemButton extends StatelessWidget {
  final VoidCallback addToDo;
  const AddToDoItemButton({super.key, required this.addToDo});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.02,
        horizontal: mediaQuery.size.width * 0.08,
      ),
      child: FloatingActionButton(
        onPressed: addToDo,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.add,
          size: 40,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
