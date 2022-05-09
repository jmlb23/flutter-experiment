import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:maisbugs/Extensions.dart';

import 'Lines.dart';
import 'Parada.dart';
import 'Paradas.dart';

abstract class Client {
  static Client getInstance() => ClientImp();

  Future<List<Line>> getLines(int id);

  Future<List<Stop>> getStops();

  Future<IndividualStop> getStop(int id);

  Future<List<Stop>> getStopLatLong(double lat, double long);
}

class ClientImp implements Client {
  final url = "https://app.tussa.org/tussa/api";

  @override
  Future<List<Line>> getLines(int id) => get("$url/lineas/$id".toUri()).toCurl()
      .asStream()
      .expand((x) {
        return jsonDecode(x.body);
      })
      .map((x) => x as Map<String, dynamic>)
      .map((x) => Line.empty()
        ..id = x['id']
        ..codigo = x['condigo']
        ..sinoptico = x['sinoptico']
        ..nombre = x['nombre']
        ..empresa = x['empresa']
        ..incidencias = x['incidencias']
        ..estilo = x['estilo'])
      .toList();

  @override
  Future<IndividualStop> getStop(int id) {
    return get("$url/paradas/$id".toUri()).toCurl()
        .then((x) => individualStopFromJson(x.body));
  }

  @override
  Future<List<Stop>> getStopLatLong(double lat, double long) {
    return post("$url/paradas/$lat/$long".toUri(),
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'}).toCurl()
        .asStream()
        .expand((x) => stopFromJson(x.body))
        .toList();
  }

  @override
  Future<List<Stop>> getStops() {
    return post("$url/paradas".toUri(),
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'}).toCurl()
        .asStream()
        .expand((x) => stopFromJson(x.body))
        .toList();
  }
}
