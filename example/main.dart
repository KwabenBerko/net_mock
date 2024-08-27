import 'dart:io';

import 'package:http/http.dart';
import 'package:net_mock/net_mock.dart';
import 'package:test/test.dart';

void main() {
  late NetMock netMock;
  late NumberRepository sut;

  setUp(() {
    netMock = NetMock();
    sut = NumberRepository(client: netMock.client);
  });

  test(
    "should return random fact for number",
    () async {
      netMock.addMock(
        request: NetMockRequest(
          url: Uri.parse("http://numbersapi.com/42"),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
          },
          method: Method.get,
        ),
        response: NetMockResponse(
          code: 200,
          body: "42 is the number of US gallons in a barrel of oil.",
        ),
      );

      final result = await sut.getFactForNumber(number: 42);

      expect(
        result,
        equals("42 is the number of US gallons in a barrel of oil."),
      );
    },
  );
}

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
