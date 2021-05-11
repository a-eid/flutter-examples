import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/networking/fetching-steam.dart';

final options = BaseOptions(
  baseUrl: 'http://localhost:3000',
);

final dio = Dio(options);
// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  runApp(
    MaterialApp(
      home: FetchingDataStream(),
    ),
  );
}
