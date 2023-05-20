import 'package:flutter/material.dart';

import 'package:to_do_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

const kScheme = ColorScheme.light(
  primary: Color.fromRGBO(219, 219, 219, 1),
  secondary: Color.fromRGBO(169, 169, 169, 1),
  onSecondary: Color.fromRGBO(56, 56, 56, 1),
  tertiary: Color.fromRGBO(255, 214, 0, 1),
  surface: Color.fromRGBO(251, 239, 180, 1),
  errorContainer: Color.fromRGBO(255, 137, 137, 1),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        colorScheme: kScheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
