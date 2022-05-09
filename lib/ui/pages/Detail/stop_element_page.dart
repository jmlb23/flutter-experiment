import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Parada.dart';
import 'package:maisbugs/ui/pages/Detail/StopElementViewModel.dart';

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
  int _idParada;
  String title;
  StopElementViewModel _elementViewModel = StopElementViewModel();

  StopElementState(this.title);

  @override
  Widget build(BuildContext context) {
    _idParada = ModalRoute.of(context).settings.arguments;
    _elementViewModel.load(_idParada);
    return Scaffold(
        appBar: AppBar(title: Text("$title")),
        body: StreamBuilder(
            stream: _elementViewModel.stops,
            builder: (bctx, data) {
              final parada = data.data as IndividualStop;
              return Column(children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(parada?.codigo ?? "", textScaleFactor: 2),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(parada?.nombre ?? "", textScaleFactor: 2),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(parada?.zona ?? "", textScaleFactor: 1),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    )),
                RefreshIndicator(
                    child: Container(
                        child: parada == null
                            ? Center(child: CircularProgressIndicator())
                            : parada.lineas.isEmpty
                                ? Container(
                                    child:
                                        Center(child: Text("Sen Resultados")))
                                : ListView.builder(
                                    itemCount: parada?.lineas?.length ?? 0,
                                    itemBuilder: (bctx, id) =>
                                        RowElement(parada?.lineas[id]),
                                  )),
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () => _elementViewModel.load(_idParada))
              ]);
            }));
  }
}

class RowElement extends StatelessWidget {
  final IndividualStopLinea parada;

  RowElement(this.parada);

  @override
  Widget build(BuildContext ctx) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
        padding: EdgeInsets.only(bottom: 10),
        child: Card(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${parada.minutosProximoPaso} min",
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
                        child: Text(parada?.sinoptico,
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
          color: Color(int.parse(parada.estilo.replaceAll("#", "0xff"))),
        ));
  }
}
