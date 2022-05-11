import 'package:flutter_test/flutter_test.dart';
import 'package:maisbugs/data/remote/Client.dart';

void main() {
  test('when a request is made should return a non empty list', () async {
    var list = await Client.getInstance().getLines();
    print(list);
    assert(list.isNotEmpty);
  });

  test('when a request is made with a valid id should return a not null item',
      () async {
    var item = await Client.getInstance().getLines();
    print(item);
    var detail =
        await Client.getInstance().getLine(item.first.id?.toInt() ?? 0);
    assert(detail != null);
  });

  test('when a request is made on /paradas should return a non empty list',
      () async {
    var list = await Client.getInstance().getStops();
    print(list);
    assert(list.isNotEmpty);
  });

  test(
      'when a request is made on /paradas/100 should return a not null element',
      () async {
    var list = await Client.getInstance().getStop(100);
    print(list);

    assert(list != null);
  });

  test(
      'when a request is made on /paradas/lat/long should return a not null element',
      () async {
    var list = await Client.getInstance().getStopLatLong(42, -8);
    print(list);

    assert(list != null);
  });
}
