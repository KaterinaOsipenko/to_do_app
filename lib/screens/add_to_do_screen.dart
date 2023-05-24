import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/background.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(169, 169, 169, 1),
        title: Text("ff"),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          const Background(),
        ],
      )),
    );
  }
}
