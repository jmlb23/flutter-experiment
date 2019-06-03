import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';

class Stop {
  num id;
  String codigo;
  String nombre;
  String zona;
  Coordenada coordenadas;
  List<LineResume> lines;
  Stop.empty();
  Stop(this.id, this.codigo, this.nombre, this.zona, this.coordenadas,
      this.lines);
}


class Coordenada {
  double lat;
  double lon;
  Coordenada.empty();
  Coordenada(this.lat, this.lon);
}

class LineResume {
  String sinoptico;
  String estilo;
}

Stream<Response> clientStops(x) => post(x, body: jsonEncode({}),headers: {'Content-Type':'application/json'}).asStream();

LineResume parser(LinkedHashMap<String,dynamic> x){
  return LineResume()..estilo = x['estilo']..sinoptico = x['sinoptico'];
}


Stream<List<Stop>> getStops() =>
    clientStops("http://app.tussa.org/tussa/api/paradas")
        .expand((x) => jsonDecode(x.body))
        .map((x) => x as Map<String, dynamic>)
        .map((x) => Stop.empty()
          ..id = x['id']
          ..codigo = x['codigo']
          ..nombre = x['nombre']
          ..zona = x['zona']
          ..coordenadas = (Coordenada.empty()
            ..lat = x['coordenadas']['latitud']
            ..lon = x['coordenadas']['longitud'])
          ..lines = ((x['lineas']) as List<dynamic>).map((y) => parser(y)).toList())
        .toList()
        .asStream();



Stream<List<Stop>> getStopsLatLon(double lat, double lon) =>
    clientStops("http://app.tussa.org/tussa/api/paradas/$lat/$lon")
        .expand((x) => jsonDecode(x.body))
        .map((x) => x as Map<String, dynamic>)
        .map((x) => Stop.empty()
      ..id = x['id']
      ..codigo = x['codigo']
      ..nombre = x['nombre']
      ..zona = x['zona']
      ..coordenadas = (Coordenada.empty()
        ..lat = x['coordenadas']['latitud']
        ..lon = x['coordenadas']['longitud'])
      ..lines = ((x['lineas']) as List<dynamic>).map((y) => parser(y)).toList())
        .toList()
        .asStream();