import 'package:flutter/material.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/models/type.dart';
import 'package:to_do_app/services/api.dart';
import 'package:to_do_app/widgets/add_to_to_button.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/widgets/to_do_item.dart';
import 'package:to_do_app/widgets/type_buttons.dart';
import 'package:to_do_app/screens/create_to_do.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late Future<List<ToDo>> _toDoList;

  int _type = 0;

  @override
  void initState() {
    super.initState();
    _loadToDoList(_type);
  }

  void _loadToDoList(int type) async {
    _type = type;
    var list = ApiSerivce.getToDoList();
    if (type == 1) {
      list = list.then((value) {
        return value.where((element) => element.type == Type.work).toList();
      });
      print('get work');
    } else if (type == 2) {
      list = list.then((value) {
        return value.where((element) => element.type == Type.personal).toList();
      });

      print('get nor work');
    }
    setState(() {
      _toDoList = list;
    });
  }

  void addToDo() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateToDo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: TypeButtons(
                        loadList: _loadToDoList,
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  builder: (context, snaphots) {
                    if (snaphots.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snaphots.hasError) {
                      return ErrorWidget(snaphots.error!);
                    }
                    if (snaphots.data!.isEmpty) {
                      return const Center(
                        child: Text("Немає подій"),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ToDoItem(
                            toDo: snaphots.data![index],
                          );
                        },
                        itemCount: snaphots.data!.length,
                      ),
                    );
                  },
                  future: _toDoList,
                ),
              ],
            ),
          ),
          AddToDoItemButton(
            addToDo: addToDo,
          ),
        ],
      ),
    );
  }
}
