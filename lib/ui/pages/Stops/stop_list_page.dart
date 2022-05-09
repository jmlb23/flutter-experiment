import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maisbugs/data/remote/Paradas.dart';
import 'package:maisbugs/ui/pages/Detail/stop_element_page.dart';

import 'StopsListViewModel.dart';

class StopListPage extends StatefulWidget {
  createState() => StopListState();
}

class StopListState extends State<StopListPage> {
  Position _position;
  StopsListViewModel _stopsListViewModel = StopsListViewModel();

  initState() {
    super.initState();
    Geolocator.isLocationServiceEnabled()
        .then((value) =>
            value ? Future.value(value) : Geolocator.requestPermission())
        .then((value) => Geolocator.getCurrentPosition().then((value) {
              _position = value;
              _stopsListViewModel.load(value.latitude, value.longitude);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: _stopsListViewModel.stops,
      builder: (bctx, snap) {
        var x = snap.data as List<Stop>;
        return x?.length == 0 || x == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
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
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Align(
                                child: Container(
                                    child: Text("${item?.codigo}",
                                        textScaleFactor: 2),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                alignment: Alignment.topLeft)),
                        Align(
                            child: Text(
                              "${item?.nombre}",
                              textScaleFactor: 2,
                            ),
                            alignment: Alignment.topLeft),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Align(
                            child: Text("${item.distancia.toInt()} mts.",
                                textScaleFactor: 1),
                            alignment: Alignment.centerLeft)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: StopIndicatorWidget(item?.lineas)),
                  ],
                ),
        )),
        onTap: () {
          Navigator.pushNamed(context, "/stops/:id",
              arguments: StopElementPageArgs(item.id, item.nombre));
        },
      );
}

class StopIndicatorWidget extends StatelessWidget {
  final List<Linea> stops;

  StopIndicatorWidget(this.stops);

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        children: stops
            .map((y) => Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${y.sinoptico}",
                      style: TextStyle(color: Colors.white),
                    )),
                color: Color(int.parse(y.estilo.replaceAll("#", "0xff")))))
            .toList());
  }
}
