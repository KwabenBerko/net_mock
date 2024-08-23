import 'dart:collection';

import 'package:http/testing.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:net_mock/src/method.dart';

import 'net_mock_request.dart';
import 'net_mock_request_response.dart';
import 'net_mock_response.dart';

/// A utility class for mocking HTTP requests and responses using `http.MockClient`.
///
/// `NetMock` is a syntactic sugar around `http.MockClient` which allows you
/// to intercept HTTP requests and provide predefined responses for testing purposes.
/// It maintains a list of mocked requests and their corresponding
/// responses, as well as a default response for unmatched requests.
class NetMock {
  late final Client client;
  final List<NetMockRequest> _interceptedRequests = [];
  final List<NetMockRequestResponse> _allowedMocks = [];
  NetMockResponse defaultResponse = NetMockResponse(code: 400);

  NetMock({
    NetMockResponse? defaultResponse,
    List<InterceptorContract>? interceptors,
  }) {
    client = InterceptedClient.build(
      interceptors: interceptors ?? [],
      client: MockClient((request) async {
        final NetMockResponse netMockResponse;
        final netMockRequest = request.toNetMockRequest;

        final allowedMock = _allowedMocks
            .where((allowedMock) => allowedMock.request == netMockRequest)
            .firstOrNull;

        if (allowedMock == null) {
          netMockResponse = defaultResponse ?? this.defaultResponse;
        } else {
          _interceptedRequests.add(netMockRequest);
          _allowedMocks.remove(allowedMock);
          netMockResponse = allowedMock.response;
        }

        return netMockResponse.toResponse;
      }),
    );
  }

  /// A list of intercepted requests that have been processed.
  List<NetMockRequest> get interceptedRequests {
    return List.unmodifiable(_interceptedRequests);
  }

  /// A list of un-intercepted requests and their corresponding responses.
  List<NetMockRequestResponse> get allowedMocks {
    return List.unmodifiable(_allowedMocks);
  }

  /// Adds a new mock request and response pair to the queue.
  void addMock({
    required NetMockRequest request,
    required NetMockResponse response,
  }) {
    final allowedMock = NetMockRequestResponse(
      request: request,
      response: response,
    );
    _allowedMocks.add(allowedMock);
  }

  /// Closes the mock client, releasing any resources.
  void close() {
    client.close();
  }
}

extension RequestExtension on Request {
  /// Extension getter to convert `http.MockClient` Request to a NetMockRequest.
  NetMockRequest get toNetMockRequest {
    return NetMockRequest(
      url: url,
      method: Method.from(method),
      headers: headers,
      body: body,
    );
  }
}

extension NetMockResponseExtension on NetMockResponse {
  /// Extension getter to convert NetMockResponse to `http.MockClient` Response.
  Response get toResponse {
    return Response(body, code, headers: headers);
  }
}
