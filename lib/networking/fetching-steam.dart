import 'dart:async';

import 'package:flutter/material.dart';
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
  StreamController<List<Todo>> streamController = StreamController();

  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    dio.get('/todos').then((value) {
      print('data loaded');
      List<Todo> todos =
          (value.data as List).map((item) => Todo.fromJson(item)).toList();

      streamController.add(todos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todos")),
      body: StreamBuilder<List<Todo>>(
        stream: streamController.stream,
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) => dio
                    .delete('/todos/${snapshot.data![index].id}')
                    .then((value) => true)
                    .catchError((_) => false),
                key: Key(snapshot.data![index].id.toString()),
                child: ListTile(
                  onTap: () {},
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].description),
                  selected: snapshot.data![index].compeleted,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
