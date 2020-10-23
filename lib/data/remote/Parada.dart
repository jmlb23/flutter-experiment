import 'Lines.dart';
import 'Paradas.dart';

class IndividualStop extends Stop {
  num id;
  String codigo;
  String nombre;
  String zona;
  Coordenada coordenadas;
  List<LineResume> lines;
  List<Line> linesTime;
  IndividualStop.empty() : super.empty();
  IndividualStop(this.id, this.codigo, this.nombre, this.zona, this.coordenadas,
      this.lines, this.linesTime)
      : super(id, codigo, nombre, zona, coordenadas, lines);
}
