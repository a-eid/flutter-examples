import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateAndBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (_) => Home(),
        '/details': (_) => Details(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home"),
      ),
      child: Container(
        constraints: BoxConstraints.expand(),
        color: CupertinoColors.systemRed,
        child: CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
          child: Text("To Next Screen"),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home"),
      ),
      child: Container(
        color: CupertinoColors.systemRed,
        constraints: BoxConstraints.expand(),
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}
