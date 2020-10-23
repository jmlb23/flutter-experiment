import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Client.dart';
import 'package:maisbugs/data/remote/Lines.dart';
import 'package:maisbugs/data/remote/Parada.dart';

class StopElementPage extends StatelessWidget {
  final int idParada;
  StopElementPage(this.idParada);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Tempos")),
        body: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 1000),
                    (x) => Client.getInstance().getStop(idParada).asStream())
                .asyncExpand((x) => x),
            builder: (bctx, data) {
              final parada = data.data as IndividualStop;
              return parada?.linesTime?.length == null ||
                      parada?.linesTime?.length < 1
                  ? Align(
                      child: Text("Sen Informacion"),
                      alignment: Alignment.center,
                    )
                  : ListView.builder(
                      itemCount: parada?.linesTime?.length,
                      itemBuilder: (bctx, id) =>
                          RowElement(parada?.linesTime[id]),
                    );
            }));
  }
}

class RowElement extends StatelessWidget {
  final Line parada;

  RowElement(this.parada);

  @override
  Widget build(BuildContext ctx) {
    return Card(
      child: Column(
        children: <Widget>[
          Align(
            child: Text(parada?.sinoptico,
                textScaleFactor: 4, style: TextStyle(color: Colors.white)),
            alignment: Alignment.center,
          ),
          Text(
            parada?.nombre ?? "Sen Informacion",
            textScaleFactor: 1,
            style: TextStyle(color: Colors.white),
          ),
          Text("${parada.minutosProximoPaso} min",
              textScaleFactor: 3, style: TextStyle(color: Colors.white))
        ],
      ),
      color: Color(int.parse(parada.estilo.replaceAll("#", "0xff"))),
    );
  }
}
