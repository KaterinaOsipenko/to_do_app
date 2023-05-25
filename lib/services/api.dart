import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/util/api_util.dart';

class ApiSerivce {
  static Future<http.Response> updateStatus(String id, int status) async {
    return await http.put(
      Uri.parse("${ApiUtil.baseUrl}${ApiUtil.tasksEndpoint}/$id"),
      body: jsonEncode(
        <String, int>{
          'status': status,
        },
      ),
    );
  }

  static Future<http.Response> createToDo(ToDo toDo) async {
    print('create');
    var response = await http.post(
      Uri.parse(ApiUtil.baseUrl + ApiUtil.tasksEndpoint),
      body: jsonEncode(
        [
          {
            "taskId": toDo.taskId,
            "status": toDo.status.number,
            "name": toDo.name,
            "type": toDo.type.number,
            "description": toDo.description,
            "finishDate": toDo.finishDate.millisecondsSinceEpoch.toInt(),
            "urgent": toDo.urgent.number,
            "file": toDo.file,
          },
        ],
      ),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create toDo ${response.reasonPhrase}.');
    }
  }

  static Future<List<ToDo>> getToDoList() async {
    final response =
        await http.get(Uri.parse(ApiUtil.baseUrl + ApiUtil.tasksEndpoint));
    List<ToDo> toDoList;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var list = data["data"] as List;
      toDoList = list.map<ToDo>((json) => ToDo.fromJson(json)).toList();
    } else {
      throw Exception(response.statusCode);
    }
    return toDoList;
  }

  static List<ToDo> parseToDo(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return parsed.map<ToDo>((json) => ToDo.fromJson(json)).toList();
  }
}
