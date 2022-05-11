import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:maisbugs/Extensions.dart';
import 'package:maisbugs/data/remote/LineDetailItem.dart';

import 'Lines.dart';
import 'Parada.dart';
import 'Paradas.dart';

abstract class Client {
  static Client getInstance() => ClientImp();

  Future<List<Line>> getLines();

  Future<LineDetailItem?> getLine(int id);

  Future<List<Stop>> getStops();

  Future<IndividualStop> getStop(int id);

  Future<List<Stop>> getStopLatLong(double lat, double long);
}

class ClientImp implements Client {
  final url = "https://app.tussa.org/tussa/api";

  @override
  Future<List<Line>> getLines() =>
      get("$url/lineas".toUri()).toCurl().then((x) {
        return lineFromJson(x.body);
      });

  @override
  Future<IndividualStop> getStop(int id) {
    return get("$url/paradas/$id".toUri())
        .toCurl()
        .then((x) => individualStopFromJson(x.body));
  }

  @override
  Future<List<Stop>> getStopLatLong(double lat, double long) {
    return post("$url/paradas/$lat/$long".toUri(),
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'})
        .toCurl()
        .then((x) => stopFromJson(x.body));
  }

  @override
  Future<List<Stop>> getStops() {
    return post("$url/paradas".toUri(),
            body: jsonEncode({}), headers: {'Content-Type': 'application/json'})
        .toCurl()
        .then((x) => stopFromJson(x.body));
  }

  @override
  Future<LineDetailItem?> getLine(int id) => get("$url/lineas/$id".toUri())
      .toCurl()
      .then((value) => lineDetailFromJson(value.body));
}
