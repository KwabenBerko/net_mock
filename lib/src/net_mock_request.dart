import 'package:equatable/equatable.dart';

import 'method.dart';

/// Represents an HTTP request in `net_mock`
class NetMockRequest extends Equatable {
  /// URL of the expected request.
  final Uri url;

  /// HTTP Method or verb of the request.
  final Method method;

  /// Optional HTTP headers of the request.
  final Map<String, String> headers;

  /// Optional HTTP body of the request.
  final String body;

  const NetMockRequest({
    required this.url,
    required this.method,
    this.headers = const {},
    this.body = "",
  });

  NetMockRequest copyWith({
    Uri? url,
    Method? method,
    Map<String, String>? headers,
    String? body,
  }) {
    return NetMockRequest(
      url: url ?? this.url,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [url, method, headers, body];
}
