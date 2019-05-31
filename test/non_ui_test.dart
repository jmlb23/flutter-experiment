import 'package:flutter_test/flutter_test.dart';
import 'package:maisbugs/data/remote/Liñas.dart';
import 'package:maisbugs/data/remote/Parada.dart';
import 'package:maisbugs/data/remote/Paradas.dart';
void main() {
  test('when a request is made should return a non empty list', () async {
    var list = await getLinesClient().toList();
     assert(list.isNotEmpty);
  });

  test('when a request is made on /paradas should return a non empty list',() async {
    var list = await getStops().first;
    assert(list.where((x) => x != null).isNotEmpty);
  });

  test('when a request is made on /paradas/100 should return a not null element',() async {
    var list = await getStop(100);
    assert(list != null);
  });
}
