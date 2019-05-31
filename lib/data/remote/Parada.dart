import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';

import 'Paradas.dart';

class Line {
  int id;
  String sinoptico;
  String nombre;
  String estilo;
  DateTime proximoPaso;
  int minutosProximoPaso;
  Line.empty();
  Line(this.id, this.sinoptico, this.nombre, this.estilo, this.proximoPaso,
      this.minutosProximoPaso);
}

class IndividualStop extends Stop {
  num id;
  String codigo;
  String nombre;
  String zona;
  Coordenada coordenadas;
  List<LineResume> lines;
  List<Line> linesTime;
  IndividualStop.empty() : super.empty();
  IndividualStop(this.id, this.codigo, this.nombre, this.zona, this.coordenadas,
      this.lines, this.linesTime)
      : super(id, codigo, nombre, zona, coordenadas, lines);
}

Future<Response> clientStop(x) => get(x);

Line paradaParser(LinkedHashMap<String, dynamic> x) {
  return Line.empty()
    ..id = x['id']
    ..nombre = x['nombre']
    ..estilo = x['estilo']
    ..sinoptico = x['sinoptico']
    ..proximoPaso = DateTime.parse(x['proximoPaso'])
    ..minutosProximoPaso = x['minutosProximoPaso'];
}

Future<IndividualStop> getStop(int id) =>
    clientStop("http://app.tussa.org/tussa/api/paradas/$id")
        .then((x) => jsonDecode(x.body))
        .then((x) {
      var w = x as Map<String, dynamic>;
      return IndividualStop.empty()
        ..id = w['id']
        ..codigo = w['codigo']
        ..nombre = w['nombre']
        ..zona = w['zona']
        ..coordenadas = (Coordenada.empty()
          ..lat = w['coordenadas']['latitud']
          ..lon = w['coordenadas']['longitud'])
        ..linesTime = ((w['lineas']) as List<dynamic>)
            .map((y) => paradaParser(y))
            .toList();
    });
