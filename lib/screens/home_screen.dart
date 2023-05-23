import 'package:flutter/material.dart';
import 'package:to_do_app/screens/to_do_list.dart';
import 'package:to_do_app/widgets/background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Center(
            child: Container(
              height: mediaQuery.size.height * 0.07,
              width: mediaQuery.size.width * 0.4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(50, 50))),
              margin: EdgeInsets.only(top: mediaQuery.size.height * 0.2),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ToDoList(),
                    ),
                  );
                },
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
        ],
      ),
    );
  }
}
