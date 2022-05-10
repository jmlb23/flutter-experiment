import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateSplash();
}

class StateSplash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, "/stops");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Text(
          "MaisBus",
          textScaleFactor: 10,
        )),
      );
}
