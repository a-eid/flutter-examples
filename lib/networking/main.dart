import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fetching.dart';

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
      home: FetchingData(),
    ),
  );
}
