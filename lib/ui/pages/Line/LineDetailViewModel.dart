import 'dart:async';

import 'package:maisbugs/data/data.dart';
import 'package:maisbugs/data/remote/LineDetailItem.dart';

class LineDetailViewModel {
  Client _client = Client.getInstance();
  StreamController<LineDetailItem?> _controller =
      StreamController<LineDetailItem>();
  StreamSink<LineDetailItem?> get _sink => _controller.sink;
  Stream<LineDetailItem?> get stream => _controller.stream;

  load(int id) async {
    var line = await _client.getLine(id);
    _sink.add(line);
  }
}
