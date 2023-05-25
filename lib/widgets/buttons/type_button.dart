// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:to_do_app/models/type.dart';

class TypeButton extends StatefulWidget {
  Type _type;

  TypeButton([
    Key? key,
    this._type = Type.work,
  ]) : super(key: key);

  Type get type => _type;

  @override
  State<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  void onChangeType(Type? value) {
    setState(() {
      widget._type = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      children: [
        for (Type type in Type.values)
          SizedBox(
            width: mediaQuery.size.width / Type.values.length,
            child: RadioListTile<Type>(
              activeColor: Theme.of(context).colorScheme.tertiary,
              value: type,
              groupValue: widget._type,
              title: Text(
                type == Type.work ? 'Робочі' : 'Особисті',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onChanged: onChangeType,
            ),
          ),
      ],
    );
  }
}
