// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'dart:developer';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:maisbugs/data/remote/Liñas.dart';
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

}
