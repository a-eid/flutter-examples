import 'package:flutter/material.dart';

class PassingParamsNamedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      // method 1 using ModalRoute.of(context)!.settings.arguments as ...
      // routes: {
      //   'home': (_) => Home(),
      //   'category': (_) => CategoryDetails(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(builder: (_) => Home());
          case 'category':
            final arguments = settings.arguments as Map<String, int>;
            return MaterialPageRoute(
              builder: (_) => CategoryDetails2(
                id: arguments['id'] ?? 0,
              ),
            );
          default:
            throw UnimplementedError(
              'the screen responding to thr route ${settings.name} is unimplemented',
            );
        }
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Category 1"),
              onPressed: () {
                Navigator.pushNamed(context, 'category', arguments: {'id': 1});
              },
            ),
            ElevatedButton(
              child: Text("Category 2"),
              onPressed: () {
                Navigator.pushNamed(context, 'category', arguments: {'id': 2});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Category ${args['id']}"),
      ),
      body: Container(
        color: Colors.cyan,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}

class CategoryDetails2 extends StatelessWidget {
  final int id;
  CategoryDetails2({required this.id});

  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category $id"),
      ),
      body: Container(
        color: Colors.cyan,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
