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
                    TypeButtons(
                      loadList: _loadToDoList,
                    ),
                  ],
                ),
                FutureBuilder(
                  builder: (context, snaphots) {
                    if (snaphots.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text(snaphots.data![index].name),
                            );
                          },
                          itemCount: snaphots.data!.length,
                        ),
                      );
                    } else if (snaphots.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snaphots.hasError) {
                      return ErrorWidget(snaphots.error!);
                    }
                  },
                  future: _toDoList,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
