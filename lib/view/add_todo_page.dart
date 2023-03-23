import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/viewmodels/add_todo_view_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  static const routeName = '/addTodo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todoを追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Taskを入力',
              ),
              onChanged: (text) {
                context.read<AddTodoViewModel>().task = text;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<AddTodoViewModel>().addTodo();
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
