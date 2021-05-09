import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateAndBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Home(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
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
        color: CupertinoColors.systemGreen,
        child: CupertinoButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute<void>(
                builder: (BuildContext context) => Details(),
              ),
            );
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
        color: CupertinoColors.systemGrey,
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
