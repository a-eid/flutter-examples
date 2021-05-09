import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroAnimation extends StatelessWidget {
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
        color: CupertinoColors.activeBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              child: Text(
                "To Next Screen",
                style: TextStyle(color: CupertinoColors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) => Details(),
                  ),
                );
              },
            ),
            Hero(
              tag: 'image-9',
              child: Image.network(
                'https://picsum.photos/250?image=9',
                height: 400,
                width: 400,
              ),
            )
          ],
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
        middle: Text("Details"),
      ),
      child: Container(
        color: CupertinoColors.destructiveRed,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'image-9',
              child: Image.network(
                'https://picsum.photos/250?image=9',
                height: 200,
                width: 200,
              ),
            ),
            CupertinoButton(
              child: Text(
                "Back",
                style: TextStyle(color: CupertinoColors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
