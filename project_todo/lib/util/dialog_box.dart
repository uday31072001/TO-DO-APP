import 'package:flutter/material.dart';
import 'package:project_todo/util/my_button.dart';


class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final VoidCallback onCancel;

  const DialogBox({
    Key? key,
    required this.controller,
    required this.onAdd,
    required this.onCancel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      backgroundColor: Colors.yellow[100],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          //get user input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: Colors.black,
                )
            ),
            child: TextField(
              controller: controller,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Add a new task',
              ),
            ),
          ),
          // save = cancel button
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //add button
              MyButton(text: 'Add', onPressed: onAdd),
              //cancel button
              MyButton(text: 'Cancel', onPressed: onCancel),
            ],
          )
        ],
      ),
    );
  }
}
