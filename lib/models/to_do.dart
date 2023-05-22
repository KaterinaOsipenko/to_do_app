// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:to_do_app/models/status.dart';
import 'package:to_do_app/models/type.dart';
import 'package:to_do_app/models/urgent.dart';

class ToDo {
  final String taskId;
  final Status status;
  final String name;
  final Type type;
  final String description;
  final String file;
  final DateTime finishDate;
  final Urgent urgent;
  final DateTime synchTime;

  ToDo({
    required this.taskId,
    required this.status,
    required this.name,
    required this.type,
    required this.description,
    required this.file,
    required this.finishDate,
    required this.urgent,
    required this.synchTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'status': status.number,
      'name': name,
      'type': type.number,
      'description': description,
      'file': file,
      'finishDate': finishDate.millisecondsSinceEpoch,
      'urgent': urgent.number,
      'synchTime': synchTime.millisecondsSinceEpoch,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      taskId: map['taskId'] as String,
      status: map['status'] as int == 1 ? Status.active : Status.done,
      name: map['name'] as String,
      type: map['type'] as int == 1 ? Type.work : Type.personal,
      description: map['description'] as String,
      file: map['file'] as String,
      finishDate: DateTime.fromMillisecondsSinceEpoch(map['finishDate'] as int),
      urgent: map['urgent'] as int == 1 ? Urgent.yes : Urgent.no,
      synchTime: DateTime.fromMillisecondsSinceEpoch(map['synchTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo.fromMap(json);
}
