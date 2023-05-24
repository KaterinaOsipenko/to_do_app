import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/background.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: mediaQuery.size.height * 0.1,
                      width: mediaQuery.size.width * 0.1,
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),

                    // Container(
                    //   color: Colors.amber,
                    //   height: 450,
                    //   width: 200,
                    // )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
