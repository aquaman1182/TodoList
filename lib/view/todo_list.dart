import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gonput_2/domain/tododata/todo.dart';
import 'package:gonput_2/view/components/bottom_navigation.dart';
import 'package:gonput_2/viewmodels/todo_list_view_model.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  static const routeName = '/TodoListPage';

  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoListViewModel todoViewModel = context.read();
    // ページ表示時に一度だけfetchTodoListを呼び出す

    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo一覧"),
        actions: [
          Builder(
            builder: (innerContext) => IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await todoViewModel.logout();
                context.go('/');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Consumer<TodoListViewModel>(
            builder: (context, todoListModel, child) {
          final List<Todo>? todo = todoListModel.todoList;
          if (todo == null) {
            return const CircularProgressIndicator();
          }

          final List<Widget> widgets = todo
              .map(
                (todo) => ListTile(
                  title: Text(todo.task),
                  subtitle: Text(todo.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await todoListModel.delete(todo);
                    },
                  ),
                ),
              )
              .toList();
          return ListView(
            children: widgets,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.go('/add_todo');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}