import 'package:flutter/material.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/services/api.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/widgets/type_buttons.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late Future<List<ToDo>> _toDoList;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  void _loadToDoList() async {
    setState(() {
      _toDoList = ApiSerivce.getToDoList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Background(),
            Container(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TypeButtons(),
                            ],
                          )
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
