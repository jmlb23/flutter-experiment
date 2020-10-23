class Line {
  num id;
  String codigo;
  String sinoptico;
  String nombre;
  String empresa;
  num incidencias;
  String estilo;
  DateTime proximoPaso;
  int minutosProximoPaso;

  Line.empty();
  Line(this.id, this.sinoptico, this.nombre, this.estilo, this.proximoPaso,
      this.minutosProximoPaso);
}
