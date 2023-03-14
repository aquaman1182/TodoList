import 'package:flutter/material.dart';
import 'package:gonput_2/add_todo/add_todo_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  static const routeName = '/addTodo';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTodoModel>(
      create: (_) => AddTodoModel(),
      child: Scaffold(
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
                  Provider.of<AddTodoModel>(context, listen: false).task = text;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await Provider.of<AddTodoModel>(context, listen: false).addTodo();
                  Navigator.pop(context);
                },
                child: const Text('追加'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}