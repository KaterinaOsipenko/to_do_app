import 'dart:convert';

import 'package:to_do_app/models/status.dart';
import 'package:to_do_app/models/type.dart';
import 'package:to_do_app/models/urgent.dart';

class ToDo {
  String _taskId;
  Status _status;
  String _name;
  Type _type;
  String _description;
  String _file;
  DateTime _finishDate;
  Urgent _urgent;
  DateTime _syncTime;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Type get type => _type;

  set type(Type value) {
    _type = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get file => _file;

  set file(String value) {
    _file = value;
  }

  DateTime get finishDate => _finishDate;

  set finishDate(DateTime value) {
    _finishDate = value;
  }

  Urgent get urgent => _urgent;

  set urgent(Urgent value) {
    _urgent = value;
  }

  DateTime get syncTime => _syncTime;

  set syncTime(DateTime value) {
    _syncTime = value;
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
  }

  String get taskId => _taskId;

  set taskId(String value) {
    _taskId = value;
  }

  ToDo({
    required String taskId,
    required Status status,
    required String name,
    required Type type,
    required String description,
    required String file,
    required DateTime finishDate,
    required Urgent urgent,
    required DateTime syncTime,
  })  : _syncTime = syncTime,
        _urgent = urgent,
        _finishDate = finishDate,
        _file = file,
        _description = description,
        _type = type,
        _name = name,
        _status = status,
        _taskId = taskId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "taskId": taskId,
      "status": status.number,
      "name": name,
      "type": type.number,
      "description": description,
      "finishDate": finishDate.toIso8601String(),
      "urgent": urgent.number,
      "file": file,
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
      finishDate: DateTime.parse(map['finishDate'] as String),
      urgent: map['urgent'] as int == 1 ? Urgent.yes : Urgent.no,
      syncTime: DateTime.parse(map['syncTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo.fromMap(json);
}
