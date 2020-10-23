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
