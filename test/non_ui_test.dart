import 'package:flutter_test/flutter_test.dart';
import 'package:maisbugs/data/remote/Client.dart';

void main() {
  test('when a request is made should return a non empty list', () async {
    var stops = await Client.getInstance().getStops();
    var list = await Client.getInstance().getLines(stops.first.id);
    print(list);
    assert(list.isNotEmpty);
  });

  test('when a request is made on /paradas should return a non empty list',
      () async {
    var list = await Client.getInstance().getStops();
    print(list);
    assert(list.where((x) => x != null).isNotEmpty);
  });

  test(
      'when a request is made on /paradas/100 should return a not null element',
      () async {
    var list = await Client.getInstance().getStop(100);
    print(list);

    assert(list != null);
  });

  test(
      'when a request is made on /paradas/100 should return a not null element',
      () async {
    var list = await Client.getInstance().getStopLatLong(42, -8);
    print(list);

    assert(list != null);
  });
}
