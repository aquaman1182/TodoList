import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gonput_2/add_todo/add_todo_page.dart';
import 'package:gonput_2/domain/todo.dart';
import 'package:gonput_2/login/login_page.dart';
import 'package:gonput_2/mypage/my_model.dart';
import 'package:gonput_2/mypage/my_page.dart';
import 'package:gonput_2/todo_list/todo_list_model.dart';
import 'package:provider/provider.dart';


class ToDoListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModele>(
      create: (_) => TodoListModele()..fetchTodoList(),
      builder: (context, child){
        return ChangeNotifierProvider<MyModel>(
          create: (_) => MyModel()..fetchUser(),
          builder: (context, child) {
         
         return Scaffold(
        appBar: AppBar(
          title: const Text("ToDo一覧"),
          actions: [
            Consumer<TodoListModele>(builder: (context, model, child) {
              return IconButton(onPressed: () {
                          model.logout();
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>const LoginPage(),
                    fullscreenDialog: true,
                  ),
                );
            }, icon: const Icon(Icons.logout));
            }),
            

            IconButton(
            onPressed: () async{
                  if (FirebaseAuth.instance.currentUser != null) {
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPage(),
                    fullscreenDialog: true,
                  ),
                );
                  } else {
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                    fullscreenDialog: true,
                  ),
                );
                  }


            }, 
            icon: const Icon(Icons.person))
          ],
        ),
        body: Center(
              child: Consumer<TodoListModele>(builder: (
                context,todoListModel,child
                ) {
                final List<Todo>? todos = todoListModel.todo;
                if (todos == null) {
                  return const CircularProgressIndicator();
                }
                 
                final List<Widget> widgets = todos
                  .map(
                    (todo) => ListTile(
                      title: Text(todo.task), 
                      subtitle: Consumer<MyModel>(
                        builder:(context, myModel, child) {
                          return Text(myModel.name ?? "");
                      }
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async{
                            await todoListModel.delete(todo);
                            await todoListModel.fetchTodoList();
                          }
                      ),
                  ),             
                ).toList();
                return ListView(
                  children: widgets,
                  );
              },
            ),
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
        );
          
       } );
          },
          );
  }   
           } 
     
     

  

