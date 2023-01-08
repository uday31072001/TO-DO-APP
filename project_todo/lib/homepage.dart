import 'package:flutter/material.dart';
import 'package:project_todo/data/database.dart';
import 'package:project_todo/util/dialog_box.dart';
import 'package:project_todo/util/my_button.dart';
import 'package:project_todo/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //reference the hive box
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  // ignore: must_call_super
  void initState() {
    //if this is first time
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  //save new task
  void saveNewTask() {
    setState(() {
      if(_controller.value.text.isEmpty){
        showInfoDialog(context,"Empty task entered");
      }
      else {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
        db.updateDataBase();
        Navigator.pop(context);
      }
    });
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDataBase();
    });
  }

  //create newTask
  void _createNewTask() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DialogBox(
            controller: _controller,
            onAdd: saveNewTask,
            onCancel: () {
              setState(() {
                _controller.clear();
              });
              Navigator.pop(context);
            },
          );
        });
    setState(() {});
  }

  showInfoDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 0.0,
        backgroundColor: Colors.yellow[100],
        title: Text(text),
        actions: <Widget>[
          MyButton(
            text: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/todo_icon.png',
          width: 2.0,
          height: 2.0,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showInfoDialog(context,"Made with </> by Uday Kumar");
            },
            icon: const Icon(
              Icons.code_rounded,
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTile: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: _createNewTask,
        tooltip: 'Add a task to do',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
