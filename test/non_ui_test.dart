import 'package:flutter_test/flutter_test.dart';
import 'package:maisbugs/data/remote/Client.dart';

void main() {
  test('when a request is made should return a non empty list', () async {
    var list = await Client.getInstance().getLines().toList();
    print(list);
    assert(list.isNotEmpty);
  });

  test('when a request is made on /paradas should return a non empty list',
      () async {
    var list = await Client.getInstance().getStops().first;
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
}
