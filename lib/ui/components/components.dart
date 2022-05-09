import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Lines.dart';

class RowWidget extends StatelessWidget {
  final Line line;

  RowWidget(this.line);

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Color(
                      int.parse(line?.estilo?.replaceAll("#", "0xff") ?? '0')),
                  child: Text("${line?.sinoptico ?? ''}")),
              Text(""),
              Text("${line?.nombre ?? ''}")
            ],
          )));
}
