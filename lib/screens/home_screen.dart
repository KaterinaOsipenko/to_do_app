import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(169, 169, 169, 1), Color(0xFF383838)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            height: mediaQuery.size.height * 0.07,
            width: mediaQuery.size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(50, 50))),
            margin: EdgeInsets.only(top: mediaQuery.size.height * 0.2),
            child: FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.tertiary),
              ),
              child: Text(
                "Вхід",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
