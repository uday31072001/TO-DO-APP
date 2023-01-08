import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function (bool?)? onChanged;
  final Function(BuildContext)? deleteTile;

  const ToDoTile({Key? key, required this.taskName, required this.taskCompleted, required this.onChanged,  required this.deleteTile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.15,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.black,
              foregroundColor: Colors.red,
              onPressed: deleteTile,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: taskCompleted?Colors.green:Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              //taskName
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted? TextDecoration.lineThrough: null ,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
