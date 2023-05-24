import 'package:flutter/material.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/models/status.dart';
import 'package:to_do_app/services/api.dart';
import 'package:to_do_app/widgets/add_to_to_button.dart';
import 'package:to_do_app/widgets/background.dart';
import 'package:to_do_app/widgets/to_do_item.dart';
import 'package:to_do_app/widgets/type_buttons.dart';
import 'package:to_do_app/screens/add_to_do_screen.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late Future<List<ToDo>> _toDoList;
  var _isLoading = true;
  final _type = 0;

  @override
  void initState() {
    super.initState();
    _loadToDoList(_type);
  }

  void _loadToDoList(int type) async {
    var list;
    if (type == 0) {
      list = ApiSerivce.getToDoList();
      print('all');
    } else if (type == 1) {
      list = ApiSerivce.getToDoList();
      print('get work');
    } else {
      list = ApiSerivce.getToDoList();
      print('get nor work');
    }
    setState(() {
      _toDoList = list;
      _isLoading = false;
    });
  }

  void onChangeStatus(bool? value, String id) {
    print('change ststat');
    ApiSerivce.updateStatus(
        id, value == true ? Status.done.number : Status.active.number);
    setState(() {
      _loadToDoList(_type);
    });
  }

  void addToDo() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddToDo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Background(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
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
                            onChangeStatus: onChangeStatus,
                          );
                        },
                        itemCount: snaphots.data!.length,
                      ),
                    );
                  },
                  future: _toDoList,
                ),
                AddToDoItemButton(
                  addToDo: addToDo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
