import 'package:http/http.dart';
import 'package:net_mock/net_mock.dart';
import 'package:net_mock/src/method.dart';
import 'package:net_mock/src/net_mock_request.dart';
import 'package:net_mock/src/net_mock_request_response.dart';
import 'package:net_mock/src/net_mock_response.dart';
import 'package:net_mock/src/resource.dart';
import 'package:test/test.dart';

void main() async {
  late NetMock sut;
  final baseUrl = Uri.parse("https://google.com");
  final defaultResponse = NetMockResponse(code: 200);
  final headers = {"Content-Type": "application/plain; charset=utf-8"};
  final testRequest1 = NetMockRequest(url: baseUrl, method: Method.get);
  final testRequest2 = testRequest1.copyWith();
  final testResponse1 = NetMockResponse(
    code: 200,
    headers: headers,
    body: await readFromResources("test_response.json"),
  );
  final testResponse2 = testResponse1.copyWith();

  setUp(() {
    sut = NetMock();
  });

  tearDown(() {
    sut.close();
  });

  test("should initialize correctly", () {
    expect(sut.client, isNotNull);
    expect(sut.interceptedRequests, isEmpty);
    expect(sut.allowedMocks, isEmpty);
  });

  test("should add requests and responses to allowedMocks list", () {
    sut.addMock(testRequest1, testResponse1);
    sut.addMock(testRequest2, testResponse2);

    expect(
      sut.allowedMocks,
      equals([
        NetMockRequestResponse(request: testRequest1, response: testResponse2),
        NetMockRequestResponse(request: testRequest2, response: testResponse2)
      ]),
    );
  });

  test(
    "should handle GET request and return a valid response",
    () async {
      final getRequest = testRequest1.copyWith();
      final getResponse = testResponse1.copyWith();
      sut.addMock(getRequest, getResponse);

      final response = await sut.client.get(baseUrl);

      _expectEquals(expected: getResponse, actual: response);
      expect([getRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle HEAD request and return a valid response",
    () async {
      final headRequest = testRequest2.copyWith(method: Method.head);
      final headResponse = testResponse1.copyWith(body: null);
      sut.addMock(headRequest, headResponse);

      final response = await sut.client.head(baseUrl);

      _expectEquals(expected: headResponse, actual: response);
      expect([headRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle POST request and return a valid response",
    () async {
      final body = '{"a": "b"}';
      final postRequest = testRequest1.copyWith(
        method: Method.post,
        headers: headers,
        body: body,
      );
      final postResponse = testResponse1.copyWith(code: 201);
      sut.addMock(postRequest, postResponse);

      final response = await sut.client.post(
        baseUrl,
        headers: headers,
        body: body,
      );

      _expectEquals(expected: postResponse, actual: response);
      expect([postRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle PUT request and return a valid response",
    () async {
      final body = '{"a": "b"}';
      final putRequest = testRequest1.copyWith(
        method: Method.put,
        headers: headers,
        body: body,
      );
      final putResponse = testResponse1.copyWith();
      sut.addMock(putRequest, putResponse);

      final response = await sut.client.put(
        baseUrl,
        headers: headers,
        body: body,
      );

      _expectEquals(expected: putResponse, actual: response);
      expect([putRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle DELETE request and return a valid response",
    () async {
      final body = '{"a": "b"}';
      final deleteRequest = testRequest1.copyWith(
        method: Method.delete,
        headers: headers,
        body: body,
      );
      final deleteResponse = testResponse1.copyWith(code: 204);
      sut.addMock(deleteRequest, deleteResponse);

      final response = await sut.client.delete(
        baseUrl,
        headers: headers,
        body: body,
      );

      _expectEquals(expected: deleteResponse, actual: response);
      expect([deleteRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle CONNECT request and return a valid response",
    () async {
      final connectRequest = testRequest1.copyWith(method: Method.connect);
      final connectResponse = testResponse1.copyWith();
      sut.addMock(connectRequest, connectResponse);

      final request = Request(Method.connect.name, baseUrl);
      final response = await sut.client.send(request);

      _expectEquals(
        expected: connectResponse,
        actual: await Response.fromStream(response),
      );
      expect([connectRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle OPTIONS request and return a valid response",
    () async {
      final optionsRequest = testRequest1.copyWith(method: Method.options);
      final optionsResponse = testResponse1.copyWith();
      sut.addMock(optionsRequest, optionsResponse);

      final request = Request(Method.options.name, baseUrl);
      final response = await sut.client.send(request);

      _expectEquals(
        expected: optionsResponse,
        actual: await Response.fromStream(response),
      );
      expect([optionsRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle TRACE request and return a valid response",
    () async {
      final traceRequest = testRequest1.copyWith(method: Method.trace);
      final traceResponse = testResponse1.copyWith();
      sut.addMock(traceRequest, traceResponse);

      final request = Request(Method.trace.name, baseUrl);
      final response = await sut.client.send(request);

      _expectEquals(
        expected: traceResponse,
        actual: await Response.fromStream(response),
      );
      expect([traceRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should handle PATCH request and return a valid response",
    () async {
      final body = '{"a": "b"}';
      final patchRequest = testRequest1.copyWith(
        method: Method.patch,
        headers: headers,
        body: body,
      );
      final patchResponse = testResponse1.copyWith();
      sut.addMock(patchRequest, patchResponse);

      final response = await sut.client.patch(
        baseUrl,
        headers: headers,
        body: body,
      );

      _expectEquals(expected: patchResponse, actual: response);
      expect([patchRequest], sut.interceptedRequests);
      expect(sut.allowedMocks, isEmpty);
    },
  );

  test(
    "should return bad request response when no queued responses are available and a default response is not set",
    () async {
      final response = await sut.client.get(baseUrl);

      _expectEquals(expected: NetMockResponse(code: 400), actual: response);
    },
  );

  test(
    "should return default response when no queued responses are available and a default response is set",
    () async {
      sut.addMock(testRequest1, testResponse1);
      sut.addMock(testRequest2, testResponse2);
      sut.defaultResponse = defaultResponse;

      final response1 = await sut.client.get(baseUrl);
      final response2 = await sut.client.get(baseUrl);
      final response3 = await sut.client.get(baseUrl);

      _expectEquals(expected: testResponse1, actual: response1);
      _expectEquals(expected: testResponse2, actual: response2);
      _expectEquals(expected: defaultResponse, actual: response3);
    },
  );
}

void _expectEquals({
  required NetMockResponse expected,
  required Response actual,
}) {
  expect(actual.statusCode, equals(expected.code));
  expect(actual.headers, equals(expected.headers));
  expect(actual.body, equals(expected.body));
}
