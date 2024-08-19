import 'package:equatable/equatable.dart';

import 'method.dart';

class NetMockRequest extends Equatable {
  final Uri url;
  final Method method;
  final Map<String, String> headers;
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
        body: body ?? this.body);
  }

  @override
  List<Object?> get props => [url, method, headers, body];
}
