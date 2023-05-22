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
}
