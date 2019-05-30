import 'package:http/http.dart';
import 'dart:convert';

class Line {
  num id;
  String codigo;
  String sinoptico;
  String nombre;
  String empresa;
  num incidencias;
  String estilo;
}

Stream<Response> client(uri) => get(uri).asStream();

Stream<List<Line>> getLinesClient() =>
    client("http://app.tussa.org/tussa/api/lineas")
        .expand((x) => jsonDecode(x.body))
        .map((x) => x as Map<String, dynamic>)
        .map((x) => Line()
          ..id = x['id']
          ..codigo = x['condigo']
          ..sinoptico = x['sinoptico']
          ..nombre = x['nombre']
          ..empresa = x['empresa']
          ..incidencias = x['incidencias']
          ..estilo = x['estilo'])
        .toList()
        .asStream();
