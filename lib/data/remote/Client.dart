import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';

import 'Lines.dart';
import 'Parada.dart';
import 'Paradas.dart';

abstract class Client {
  static Client getInstance() => ClientImp();
  Stream<List<Line>> getLines();
  Stream<List<Stop>> getStops();
  Future<IndividualStop> getStop(int id);
  Stream<List<Stop>> getStopLatLong(double lat, double long);
}

class ClientImp implements Client {
  final url = "https://app.tussa.org/tussa/api";

  @override
  Stream<List<Line>> getLines() => get("$url/lineas")
      .asStream()
      .expand((x) => jsonDecode(x.body))
      .map((x) => x as Map<String, dynamic>)
      .map((x) => Line.empty()
        ..id = x['id']
        ..codigo = x['condigo']
        ..sinoptico = x['sinoptico']
        ..nombre = x['nombre']
        ..empresa = x['empresa']
        ..incidencias = x['incidencias']
        ..estilo = x['estilo'])
      .toList()
      .asStream();

  @override
  Future<IndividualStop> getStop(int id) {
    Line paradaParser(LinkedHashMap<String, dynamic> x) {
      return Line.empty()
        ..id = x['id']
        ..nombre = x['nombre']
        ..estilo = x['estilo']
        ..sinoptico = x['sinoptico']
        ..proximoPaso = DateTime.parse(x['proximoPaso'])
        ..minutosProximoPaso = x['minutosProximoPaso'];
    }

    return get("$url/$id").then((x) => jsonDecode(x.body)).then((x) {
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
  }

  @override
  Stream<List<Stop>> getStopLatLong(double lat, double long) {
    LineResume parser(LinkedHashMap<String, dynamic> x) {
      return LineResume()
        ..estilo = x['estilo']
        ..sinoptico = x['sinoptico'];
    }

    return post("$url/$lat/$long",
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'})
        .asStream()
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
          ..lines =
              ((x['lineas']) as List<dynamic>).map((y) => parser(y)).toList())
        .toList()
        .asStream();
  }

  @override
  Stream<List<Stop>> getStops() {
    LineResume parser(LinkedHashMap<String, dynamic> x) {
      return LineResume()
        ..estilo = x['estilo']
        ..sinoptico = x['sinoptico'];
    }

    return post("$url/paradas",
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'})
        .asStream()
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
          ..lines =
              ((x['lineas']) as List<dynamic>).map((y) => parser(y)).toList())
        .toList()
        .asStream();
  }
}
