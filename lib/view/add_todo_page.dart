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
            autovalidateMode: AutovalidateMode.disabled, autofocus: true,
            decoration: const InputDecoration(
              labelText: "Let's add a task!", // ラベル
              hintText: 'Taskを入力', // 入力ヒント
            ), // 入力変化しても自動でチェックしない。trueにすると初期状態および入力が変化する毎に自動でvalidatorがコールされる
            validator: (value) { // _formKey.currentState.validate()でコールされる
              if (value!.isEmpty) {
                return 'Please enter some text'; // エラー表示のメッセージを返す
              }
              return null; // 問題ない場合はnullを返す
            }, 
            onSaved: (value) => () { // this._formKey.currentState.save()でコールされる
              print('$value');
            },
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
