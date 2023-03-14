import 'package:flutter/material.dart';
import 'package:gonput_2/add_todo/add_todo_page.dart';
import 'package:gonput_2/domain/todo.dart';
import 'package:gonput_2/login/login_page.dart';
import 'package:gonput_2/mypage/my_model.dart';
import 'package:gonput_2/mypage/my_page.dart';
import 'package:gonput_2/todo_list/todo_list_model.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  static const routeName = '/TodoListPage';

  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModel>(
      create: (_) => TodoListModel(),
      builder: (context, child) {
        // ページ表示時に一度だけfetchTodoListを呼び出す
        Provider.of<TodoListModel>(context, listen: false).fetchTodoList();

        return Scaffold(
          appBar: AppBar(
            title: const Text("ToDo一覧"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await Provider.of<TodoListModel>(context, listen: false)
                      .logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.routeName, (_) => false);
                },
              ),
            ],
          ),
          body: Center(
            child: Consumer2<TodoListModel, MyModel>(
              builder: (
                context,
                todoListModel,
                myModel,
                child,
              ) {
                final List<Todo>? todo = todoListModel.todoList;
                if (todo == null) {
                  return const CircularProgressIndicator();
                }

                final List<Widget> widgets = todo
                    .map(
                      (todo) => ListTile(
                        title: Text(todo.task),
                        subtitle: Text(myModel.name ?? ""),
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
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AddTodoPage.routeName,
              );
              await Provider.of<TodoListModel>(context, listen: false)
                  .fetchTodoList();
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (int index) {
              if (index == 1) {
                Navigator.pushNamed(context, MyPage.routeName);
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: "TodoList"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "MyPage"),
            ],
          ),
        );
      },
    );
  }
}
