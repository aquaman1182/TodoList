
import 'package:flutter/material.dart';
import 'package:gonput_2/add_todo/add_todo_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTodoModele>(
       create: (_) => AddTodoModele(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ToDo一覧"),
        ),
        body: Center(
          child: Consumer<AddTodoModele>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                  TextField(
                  decoration: const InputDecoration(
                    hintText: "タスクを入れる"
                  ),
                  onChanged: (text) {
                      model.task = text;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                  TextField(
                  decoration: const InputDecoration(
                    hintText: "名前を入れる"
                  ),
                  onChanged: (text) {
                      model.user = text;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    model.addTodo();
                  },
                child: const Text("追加")),
              ],),
            );
          }
        ),
        
          ),
      ),
    );
  }
}