import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Li%C3%B1as.dart';
import 'package:maisbugs/ui/pages/search_line_page.dart';
import 'package:maisbugs/ui/pages/stop_list_page.dart';

class RowWidget extends StatelessWidget {
  Line line;
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

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: DrawerHeader(
              curve: Curves.elasticIn,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
              ),
            ),
          ),
          ListTile(
              title: Text("Paradas Cercanas"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (b) => StopListPage()));
              }),
          ListTile(
              title: Text("Buscar Paradas"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (b) => SearchLinePage()));
              })
        ],
      ),
    );
  }
}
