import 'dart:async';

import 'package:flutter/material.dart';
import 'eye_dry.dart';

class Dummy1 extends StatelessWidget {
  static const routeName = '/return';

  _delayBack(BuildContext ctx) {
    Timer(Duration(seconds: 5), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              colorList[0] = Colors.grey;
              print(colorList[0]);
              Navigator.popAndPushNamed(context, Dummy1.routeName,
                  arguments: {"_pageList": "1"});
            },
            child: Text('go back test')),
      ),
    );
  }
}
