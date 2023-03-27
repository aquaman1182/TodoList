import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/add_todo_view_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  static const routeName = '/addTodo';
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AddTodoViewModel addTodoViewModel = context.read();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoを追加'),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              context.go("/todo_list");
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Let's add a task!", 
                hintText: 'Taskを入力', 
              ), 
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await addTodoViewModel.addTodo(
                  taskController.text
                );
                context.go("/todo_list");
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
