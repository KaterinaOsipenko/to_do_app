// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:to_do_app/models/urgent.dart';

class UrgentButton extends StatefulWidget {
  Urgent _urgent;

  UrgentButton([
    Key? key,
    this._urgent = Urgent.no,
  ]) : super(key: key);

  Urgent get urgent => _urgent;

  set urgent(Urgent value) {
    _urgent = value;
  }

  @override
  State<UrgentButton> createState() => _UrgentButtonState();
}

class _UrgentButtonState extends State<UrgentButton> {
  Urgent urgent = Urgent.no;
  void onChangeUrgent(bool? value) {
    setState(() {
      urgent = value == true ? Urgent.yes : Urgent.no;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.005,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.size.width * 0.07,
        vertical: mediaQuery.size.height * 0.03,
      ),
      child: Transform.scale(
        scale: 1,
        child: CheckboxListTile(
          checkboxShape: const CircleBorder(),
          checkColor: Theme.of(context).colorScheme.errorContainer,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            'Терміново',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          activeColor: Theme.of(context).colorScheme.errorContainer,
          value: urgent == Urgent.yes ? true : false,
          onChanged: onChangeUrgent,
        ),
      ),
    );
  }
}
