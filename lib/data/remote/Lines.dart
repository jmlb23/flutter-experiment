import 'dart:convert';

List<Line> lineFromJson(String str) =>
    List<Line>.from(json.decode(str).map((x) => Line.fromJson(x)));

String lineToJson(List<Line> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Line {
  Line({
    this.id,
    this.codigo,
    this.sinoptico,
    this.nombre,
    this.empresa,
    this.incidencias,
    this.estilo,
  });

  int? id;
  String? codigo;
  String? sinoptico;
  String? nombre;
  String? empresa;
  int? incidencias;
  String? estilo;

  factory Line.fromJson(Map<String, dynamic> json) => Line(
        id: json["id"],
        codigo: json["codigo"],
        sinoptico: json["sinoptico"],
        nombre: json["nombre"],
        empresa: json["empresa"],
        incidencias: json["incidencias"],
        estilo: json["estilo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "sinoptico": sinoptico,
        "nombre": nombre,
        "empresa": empresa,
        "incidencias": incidencias,
        "estilo": estilo,
      };
}
