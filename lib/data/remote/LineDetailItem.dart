// To parse this JSON data, do
//
//     final lineDetail = lineDetailFromJson(jsonString);

import 'dart:convert';

LineDetailItem lineDetailFromJson(String? str) =>
    LineDetailItem.fromJson(json.decode(str ?? ""));

String? lineDetailToJson(LineDetailItem data) => json.encode(data.toJson());

class LineDetailItem {
  LineDetailItem({
    this.id,
    this.codigo,
    this.sinoptico,
    this.nombre,
    this.informacion,
    this.estilo,
    required this.trayectos,
    required this.incidencias,
  });

  int? id;
  String? codigo;
  String? sinoptico;
  String? nombre;
  String? informacion;
  String? estilo;
  List<TrayectoDetailItem> trayectos;
  List<Incidencia> incidencias;

  factory LineDetailItem.fromJson(Map<String, dynamic> json) => LineDetailItem(
        id: json["id"],
        codigo: json["codigo"],
        sinoptico: json["sinoptico"],
        nombre: json["nombre"],
        informacion: json["informacion"],
        estilo: json["estilo"],
        trayectos: List<TrayectoDetailItem>.from(json["trayectos"]
                ?.map((x) => TrayectoDetailItem.fromJson(x ?? {})) ??
            []),
        incidencias: List<Incidencia>.from(
            json["incidencias"]?.map((x) => Incidencia.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "sinoptico": sinoptico,
        "nombre": nombre,
        "informacion": informacion,
        "estilo": estilo,
        "trayectos": List<dynamic>.from(trayectos.map((x) => x.toJson())),
        "incidencias": List<dynamic>.from(incidencias.map((x) => x)),
      };
}

class TrayectoDetailItem {
  TrayectoDetailItem({
    this.nombre,
    this.sentido,
    required this.paradas,
  });

  String? nombre;
  String? sentido;
  List<ParadaDetailItem> paradas;

  factory TrayectoDetailItem.fromJson(Map<String, dynamic> json) =>
      TrayectoDetailItem(
        nombre: json["nombre"],
        sentido: json["sentido"],
        paradas: List<ParadaDetailItem>.from(
            json["paradas"]?.map((x) => ParadaDetailItem.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "sentido": sentido,
        "paradas": List<dynamic>.from(paradas.map((x) => x.toJson())),
      };
}

class ParadaDetailItem {
  ParadaDetailItem({
    this.id,
    this.codigo,
    this.nombre,
    this.zona,
    this.extraordinaria,
    this.coordenadasDetail,
  });

  int? id;
  String? codigo;
  String? nombre;
  String? zona;
  bool? extraordinaria;
  CoordenadasDetailItem? coordenadasDetail;

  factory ParadaDetailItem.fromJson(Map<String, dynamic> json) =>
      ParadaDetailItem(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        zona: json["zona"] == null ? null : json["zona"],
        extraordinaria: json["extraordinaria"],
        coordenadasDetail:
            CoordenadasDetailItem.fromJson(json["CoordenadasDetailItem"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "zona": zona == null ? null : zona,
        "extraordinaria": extraordinaria,
        "CoordenadasDetailItem": coordenadasDetail?.toJson(),
      };
}

class Incidencia {
  Incidencia({
    this.id,
    this.titulo,
    this.descripcion,
    this.inicio,
    this.fin,
  });

  int? id;
  String? titulo;
  String? descripcion;
  String? inicio;
  String? fin;

  factory Incidencia.fromJson(Map<String, dynamic> json) => Incidencia(
        id: json["id"] == null ? null : json["id"],
        titulo: json["titulo"] == null ? null : json["titulo"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        inicio: json["inicio"] == null ? null : json["inicio"],
        fin: json["fin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "titulo": titulo == null ? null : titulo,
        "descripcion": descripcion == null ? null : descripcion,
        "inicio": inicio == null ? null : inicio,
        "fin": fin,
      };
}

class CoordenadasDetailItem {
  CoordenadasDetailItem({
    this.latitud,
    this.longitud,
  });

  double? latitud;
  double? longitud;

  factory CoordenadasDetailItem.fromJson(Map<String, dynamic> json) =>
      CoordenadasDetailItem(
        latitud: json["latitud"]?.toDouble(),
        longitud: json["longitud"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitud": latitud,
        "longitud": longitud,
      };
}
