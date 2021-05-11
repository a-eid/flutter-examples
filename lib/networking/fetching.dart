import 'package:flutter/material.dart';
import 'main.dart';

class Todo {
  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'] ?? '',
        compeleted = json['compeleted'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'compeleted': compeleted,
      };

  String title;
  String description;
  bool compeleted;
}

class FetchingData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FetchingData();
  }
}

class _FetchingData extends State<FetchingData> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    dio.get('/todos').then((value) {
      setState(() {
        (value.data as List).forEach((item) {
          todos.add(Todo.fromJson(item));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todos")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            enableFeedback: true,
            onTap: () {},
            tileColor: todos[index].compeleted ? Colors.white : Colors.blue,
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
            selected: todos[index].compeleted,
          );
        },
      ),
    );
  }
}
