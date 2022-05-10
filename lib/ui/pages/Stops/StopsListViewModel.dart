import 'dart:async';

import 'package:maisbugs/data/remote/Client.dart';
import 'package:maisbugs/data/remote/Paradas.dart';

class StopsListViewModel {
  Client _client = Client.getInstance();
  StreamController<List<Stop>> _streamController = StreamController();

  Stream<List<Stop>> get stops => _streamController.stream;

  Sink<List<Stop>> get _stopsSink => _streamController.sink;

  load(double lat, double long) async {
    var stop = await _client.getStopLatLong(lat, long);
    _stopsSink.add(stop);
  }
}
