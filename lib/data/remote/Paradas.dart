// To parse this JSON data, do
//
//     final stop = stopFromJson(jsonString);

import 'dart:convert';

List<Stop> stopFromJson(String str) =>
    List<Stop>.from(json.decode(str).map((x) => Stop.fromJson(x)));

String stopToJson(List<Stop> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stop {
  Stop({
    this.id,
    this.codigo,
    this.nombre,
    this.zona,
    this.distancia,
    this.coordenadas,
    this.lineas,
  });

  int id;
  String codigo;
  String nombre;
  String zona;
  double distancia;
  Coordenadas coordenadas;
  List<Linea> lineas;

  factory Stop.fromJson(Map<String, dynamic> json) => Stop(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        zona: json["zona"] == null ? null : json["zona"],
        distancia: json["distancia"].toDouble(),
        coordenadas: Coordenadas.fromJson(json["coordenadas"]),
        lineas: List<Linea>.from(json["lineas"].map((x) => Linea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "zona": zona == null ? null : zona,
        "distancia": distancia,
        "coordenadas": coordenadas.toJson(),
        "lineas": List<dynamic>.from(lineas.map((x) => x.toJson())),
      };
}

class Coordenadas {
  Coordenadas({
    this.latitud,
    this.longitud,
  });

  double latitud;
  double longitud;

  factory Coordenadas.fromJson(Map<String, dynamic> json) => Coordenadas(
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
      };
}

class Linea {
  Linea({
    this.sinoptico,
    this.estilo,
  });

  String sinoptico;
  String estilo;

  factory Linea.fromJson(Map<String, dynamic> json) => Linea(
        sinoptico: json["sinoptico"],
        estilo: json["estilo"],
      );

  Map<String, dynamic> toJson() => {
        "sinoptico": sinoptico,
        "estilo": estilo,
      };
}
