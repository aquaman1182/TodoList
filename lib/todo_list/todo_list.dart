
import 'package:flutter/material.dart';
import 'package:gonput_2/add_todo/add_todo_page.dart';
import 'package:gonput_2/domain/todo.dart';
import 'package:gonput_2/todo_list/todo_list_model.dart';
import 'package:provider/provider.dart';

class ToDoListPage extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModele>(
       create: (_) => TodoListModele()..fetchTodoList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ToDo一覧"),
        ),
        body: Center(
          child: Consumer<TodoListModele>(builder: (context, model, child) {
            final List<Todo>? todos = model.todos;

            if (todos == null) {
              return const CircularProgressIndicator();
            }
            final List<Widget> widgets = todos.map(
              (todo) => ListTile(
                title: Text(todo.task), 
                subtitle: Text(todo.user),
              ),
            ).toList();
            return ListView(
              children: widgets,
              );
          },
        )
        
          ),
          floatingActionButton: Consumer<TodoListModele>(builder: (context, model, child) {
              return FloatingActionButton(
                onPressed: () async{
                   await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTodoPage(),
                    fullscreenDialog: true,
                    ),
                  );
                    model.fetchTodoList();
                },
                tooltip: "Increment",
                child: const Icon(Icons.add),
                
              );
            }
          ),
      ),
    );
  }
}