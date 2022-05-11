import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Parada.dart';
import 'package:maisbugs/ui/pages/Stops/Detail/StopElementViewModel.dart';

class StopElementPageArgs {
  int id;
  String title;

  StopElementPageArgs(this.id, this.title);
}

class StopElementPage extends StatefulWidget {
  final String title;

  StopElementPage(this.title);

  createState() {
    return StopElementState(this.title);
  }
}

class StopElementState extends State<StopElementPage> {
  int? _idParada = null;
  String title;
  StopElementViewModel _elementViewModel = StopElementViewModel();

  StopElementState(this.title);

  @override
  void didChangeDependencies() {
    _idParada =
        int.parse(ModalRoute.of(context)?.settings.arguments.toString() ?? "0");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      builder: (context, snapshot) => Scaffold(
          appBar: AppBar(title: Text("$title")),
          body: StreamBuilder(
              stream: _elementViewModel.stops,
              builder: (bctx, data) {
                final parada = data.data as IndividualStop?;
                return RefreshIndicator(
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: Column(children: [
                          parada == null
                              ? Container()
                              : Column(children: [
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(parada.codigo ?? "",
                                                textScaleFactor: 2),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Container(
                                            child: Text(parada.nombre ?? "",
                                                textScaleFactor: 2),
                                            padding: EdgeInsets.all(5),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(parada.zona ?? "",
                                                textScaleFactor: 1),
                                            padding: EdgeInsets.all(5),
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      color: Colors.grey[300],
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text("Proximas liñas",
                                                textScaleFactor: 1),
                                            padding: EdgeInsets.all(5),
                                          ),
                                        ],
                                      )),
                                ]),
                          Flexible(
                              child: Container(
                                  child: parada == null
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : (parada.lineas ?? []).isEmpty
                                          ? Container(
                                              child: Center(
                                                  child:
                                                      Text("Sen Resultados")))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  parada.lineas?.length ?? 0,
                                              itemBuilder: (bctx, id) =>
                                                  RowElement(
                                                      parada.lineas?[id]),
                                            )))
                        ])),
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () => _idParada != null
                        ? _elementViewModel.load(_idParada!)
                        : () {}());
              })),
      future: _idParada != null ? _elementViewModel.load(_idParada!) : () {}());
}

class RowElement extends StatelessWidget {
  final IndividualStopLinea? parada;

  RowElement(this.parada);

  @override
  Widget build(BuildContext ctx) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
        padding: EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(ctx, "/line/:id", arguments: parada?.id),
          child: Card(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${parada?.minutosProximoPaso} min",
                            textScaleFactor: 3,
                            style: TextStyle(color: Colors.white)),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Text("-",
                              textScaleFactor: 3,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Align(
                          child: Text(parada?.sinoptico ?? "",
                              textScaleFactor: 3,
                              style: TextStyle(color: Colors.white)),
                          alignment: Alignment.center,
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      parada?.nombre ?? "Sen Informacion",
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            color: Color(int.parse(
                parada?.estilo?.replaceAll("#", "0xff") ?? "0xffffffff")),
          ),
        ));
  }
}
