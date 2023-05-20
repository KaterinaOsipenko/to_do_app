import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(169, 169, 169, 1), Color(0xFF383838)],
          ),
        ),
        child: OutlinedButton(
          onPressed: () {},
          child: const Text("Вхід"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ),
    );
  }
}
