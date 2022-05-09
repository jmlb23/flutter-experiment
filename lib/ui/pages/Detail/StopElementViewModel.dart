import 'dart:async';

import 'package:maisbugs/data/remote/Client.dart';
import 'package:maisbugs/data/remote/Parada.dart';

class StopElementViewModel {
  Client _client = Client.getInstance();
  StreamController<IndividualStop> _streamController = StreamController();
  Stream<IndividualStop> get stops => _streamController.stream;
  Sink<IndividualStop> get _stopsSink => _streamController.sink;

  load(int id) async {
    var stop = await _client.getStop(id);
    _stopsSink.add(stop);
  }
}
