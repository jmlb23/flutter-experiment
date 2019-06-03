import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maisbugs/ui/pages/stop_list_page.dart';
import 'package:geolocator/geolocator.dart';


class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateSplash();

}

class StateSplash extends State<Splash>{

  @override
  void initState() {
    Timer(Duration(seconds: 2), () { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => StopListPage()));});
  }

  @override
  Widget build(BuildContext context) => Scaffold(body:
    Center(child: Text("MaisBus",textScaleFactor: 3,)),backgroundColor: Colors.blue,);

}