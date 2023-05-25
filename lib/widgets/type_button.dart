import 'package:flutter/material.dart';
import 'package:to_do_app/models/type.dart';

class TypeButton extends StatefulWidget {
  const TypeButton({super.key});

  @override
  State<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends State<TypeButton> {
  Type? _typeItem = Type.work;

  void onChangeType(Type? value) {
    setState(() {
      _typeItem = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      children: [
        for (Type type in Type.values)
          Container(
            width: mediaQuery.size.width / Type.values.length,
            child: RadioListTile<Type>(
              activeColor: Theme.of(context).colorScheme.tertiary,
              value: type,
              groupValue: _typeItem,
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
