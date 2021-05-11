import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_examples/networking/main.dart';

import 'fetching.dart';

class AddTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Container(
        color: Colors.red,
        child: ElevatedButton(
          child: Text('Add Random Todo'),
          onPressed: () async {
            await dio.post(
              '/todos',
              data: Todo(
                title: faker.lorem.sentence(),
                description: faker.lorem.sentences(2).join(', '),
                compeleted: false,
              ).toJson(),
            );
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
