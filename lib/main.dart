import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maisbugs/ui/pages/list_line_page.dart';
import 'package:maisbugs/ui/pages/splash.dart';
import 'package:maisbugs/ui/pages/stop_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
