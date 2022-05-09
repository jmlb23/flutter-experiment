import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

extension UriParser on String {
  Uri toUri() => Uri.parse(this);
}

extension HTTPCurl on Future<Response> {
  Future<Response> toCurl() {
    return this
        .then((value) =>
            "curl -X ${value.request.method} \"${value.request.url}\" ${value.request.headers.entries.map((entrie) => "-H \"${entrie.key}: ${entrie.value}\" ").join(" ")} ")
        .then((value) => print(value))
        .then((value) => this);
  }
}
