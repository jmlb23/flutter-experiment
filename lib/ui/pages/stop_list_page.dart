import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Paradas.dart';
import 'package:quiver/iterables.dart';

class StopListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lista de Paradas")),
        body: StreamBuilder(
          stream: getStops(),
          builder: (bctx, snap) {
            var x = snap.data as List<Stop>;
            return ListView.builder(
              itemCount: (x)?.length,
              itemBuilder: (bctx, i) => GestureDetector(
                    onTap: () {},
                    child: x == null
                        ? ListItemComponent(null)
                        : ListItemComponent(x?.elementAt(i)),
                  ),
            );
          },
        ));
  }
}

class ListItemComponent extends StatelessWidget {
  final Stop item;
  ListItemComponent(this.item);

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Card(
            child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
          child: item == null
              ? Column(
                  children: <Widget>[],
                )
              : Column(
                  children: <Widget>[
                    Align(
                        child: Text("${item?.zona}",textScaleFactor: 2,),
                        alignment: Alignment.topLeft),
                    Align(
                        child: Text("${item?.nombre}"),
                        alignment: Alignment.topLeft),
                    StopIndicatorWidget(item?.lines),
                  ],
                ),
        )),
        onTap: () {
          Scaffold.of(context).showSnackBar(SnackBar(content:Text("${item.id}")));
        },
      );
}

class StopIndicatorWidget extends StatelessWidget {
  List<LineResume> stops;
  StopIndicatorWidget(this.stops);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: partition(stops, 6)
            .map((x) => Row(
                children: x
                    .map((y) => CircleAvatar(
                        child: Text("${y.sinoptico}"),
                        backgroundColor:
                            Color(int.parse(y.estilo.replaceAll("#", "0xff")))))
                    .toList()))
            .toList());
  }
}
