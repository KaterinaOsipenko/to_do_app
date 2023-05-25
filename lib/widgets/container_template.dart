import 'package:flutter/material.dart';

class ContainerTemplate extends StatelessWidget {
  final double width;
  final Widget child;

  const ContainerTemplate(
      {super.key, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: width,
      color: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.005,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.size.width * 0.07,
          vertical: mediaQuery.size.height * 0.03),
      child: child,
    );
  }
}
