import 'dart:io';

import 'package:http/http.dart';

class NumberRepository {
  final Client client;

  NumberRepository({required this.client});

  Future<String> getFactForNumber({required int number}) async {
    final response = await client.get(
      Uri.parse("http://numbersapi.com/$number"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
      },
    );
    return response.body;
  }
}
