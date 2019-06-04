
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchLinePage extends StatefulWidget {
  @override
  _SearchLinePageState  createState() => _SearchLinePageState();
}

class _SearchLinePageState extends State<SearchLinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar"),),
    );
  }
}