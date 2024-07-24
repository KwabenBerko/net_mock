import 'dart:collection';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:net_mock/src/method.dart';

import 'net_mock_request.dart';
import 'net_mock_request_response.dart';
import 'net_mock_response.dart';

class NetMock {
  late final MockClient client;
  final List<NetMockRequest> _interceptedRequests = [];
  final List<NetMockRequestResponse> _allowedMocks = [];
  NetMockResponse defaultResponse = NetMockResponse(code: 400);

  NetMock({NetMockResponse? defaultResponse}) {
    client = MockClient((request) async {
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
    });
  }

  List<NetMockRequest> get interceptedRequests {
    return List.unmodifiable(_interceptedRequests);
  }

  List<NetMockRequestResponse> get allowedMocks {
    return List.unmodifiable(_allowedMocks);
  }

  void addMock(NetMockRequest request, NetMockResponse response) {
    final allowedMock = NetMockRequestResponse(
      request: request,
      response: response,
    );
    _allowedMocks.add(allowedMock);
  }

  void close() {
    client.close();
  }
}

extension RequestExtension on Request {
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
  Response get toResponse {
    return Response(body, code, headers: headers);
  }
}
