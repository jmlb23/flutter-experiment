import 'dart:convert';

IndividualStop individualStopFromJson(String str) => IndividualStop.fromJson(json.decode(str));

String individualStopToJson(IndividualStop data) => json.encode(data.toJson());

class IndividualStop {
  IndividualStop({
    this.id,
    this.codigo,
    this.nombre,
    this.zona,
    this.coordenadas,
    this.lineas,
  });

  int id;
  String codigo;
  String nombre;
  dynamic zona;
  IndividualStopCoordenadas coordenadas;
  List<IndividualStopLinea> lineas;

  factory IndividualStop.fromJson(Map<String, dynamic> json) => IndividualStop(
    id: json["id"],
    codigo: json["codigo"],
    nombre: json["nombre"],
    zona: json["zona"],
    coordenadas: IndividualStopCoordenadas.fromJson(json["coordenadas"]),
    lineas: List<IndividualStopLinea>.from(json["lineas"].map((x) => IndividualStopLinea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "codigo": codigo,
    "nombre": nombre,
    "zona": zona,
    "coordenadas": coordenadas.toJson(),
    "lineas": List<dynamic>.from(lineas.map((x) => x.toJson())),
  };
}

class IndividualStopCoordenadas {
  IndividualStopCoordenadas({
    this.latitud,
    this.longitud,
  });

  double latitud;
  double longitud;

  factory IndividualStopCoordenadas.fromJson(Map<String, dynamic> json) => IndividualStopCoordenadas(
    latitud: json["latitud"].toDouble(),
    longitud: json["longitud"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitud": latitud,
    "longitud": longitud,
  };
}

class IndividualStopLinea {
  IndividualStopLinea({
    this.id,
    this.sinoptico,
    this.nombre,
    this.estilo,
    this.proximoPaso,
    this.minutosProximoPaso,
  });

  int id;
  String sinoptico;
  String nombre;
  String estilo;
  String proximoPaso;
  int minutosProximoPaso;

  factory IndividualStopLinea.fromJson(Map<String, dynamic> json) => IndividualStopLinea(
    id: json["id"],
    sinoptico: json["sinoptico"],
    nombre: json["nombre"],
    estilo: json["estilo"],
    proximoPaso: json["proximoPaso"],
    minutosProximoPaso: json["minutosProximoPaso"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sinoptico": sinoptico,
    "nombre": nombre,
    "estilo": estilo,
    "proximoPaso": proximoPaso,
    "minutosProximoPaso": minutosProximoPaso,
  };
}
