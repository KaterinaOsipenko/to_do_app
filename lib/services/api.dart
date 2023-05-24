import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:to_do_app/models/to_do.dart';
import 'package:to_do_app/util/api_util.dart';

class ApiSerivce {
  static Future<http.Response> updateStatus(String id, int status) {
    return http.put(
      Uri.parse("${ApiUtil.baseUrl}${ApiUtil.tasksEndpoint}/$id"),
      body: jsonEncode(
        <String, int>{
          'status': status,
        },
      ),
    );
  }

  static Future<List<ToDo>> getToDoList() async {
    final response =
        await http.get(Uri.parse(ApiUtil.baseUrl + ApiUtil.tasksEndpoint));
    List<ToDo> toDoList;
    if (response.statusCode == 200) {
      print('200');
      var data = jsonDecode(response.body);

      var list = data["data"] as List;
      toDoList = list.map<ToDo>((json) => ToDo.fromJson(json)).toList();
    } else {
      print('error ${response.reasonPhrase}');
      throw Exception(response.statusCode);
    }
    return toDoList;
  }

  static List<ToDo> parseToDo(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return parsed.map<ToDo>((json) => ToDo.fromJson(json)).toList();
  }
}
