import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_examples/networking/add-todo.dart';
import 'main.dart';

class Todo {
  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'] ?? '',
        compeleted = json['compeleted'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'compeleted': compeleted,
        'id': id
      };

  int id;
  String title;
  String description;
  bool compeleted;
}

class FetchingDataStream extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FetchingDataStream();
  }
}

class _FetchingDataStream extends State<FetchingDataStream> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    dio.get('/todos').then((value) {
      print('data loaded');
      List<Todo> elements =
          (value.data as List).map((item) => Todo.fromJson(item)).toList();

      setState(() {
        todos = elements;
      });
    });
  }

  void handleAddPress() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodo(),
      ),
    );

    // we can probaly return a true / false and loadData conditionally.
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
        actions: [IconButton(onPressed: handleAddPress, icon: Icon(Icons.add))],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            confirmDismiss: (_) async {
              bool deleted = await dio
                  .delete('/todos/${todos[index].id}')
                  .then((value) => true)
                  .catchError((_) => false);

              if (deleted) {
                await loadData();
                return true;
              } else {
                return false;
              }
            },
            key: Key(todos[index].id.toString()),
            child: Container(
              color: Colors.green,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: ListTile(
                onTap: () {},
                title: Text(todos[index].title),
                subtitle: Text(todos[index].description),
                selected: todos[index].compeleted,
              ),
            ),
          );
        },
      ),
    );
  }
}
