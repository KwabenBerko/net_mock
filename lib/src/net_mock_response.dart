import 'package:equatable/equatable.dart';

/// Represents an HTTP response in `net_mock`
class NetMockResponse extends Equatable {
  /// HTTP status code of the expected response.
  final int code;

  /// HTTP headers of the expected response.
  final Map<String, String> headers;

  /// HTTP body of the expected response.
  final String body;

  const NetMockResponse({
    required this.code,
    this.headers = const {},
    this.body = "",
  });

  NetMockResponse copyWith({
    int? code,
    Map<String, String>? headers,
    String? body,
  }) {
    return NetMockResponse(
      code: code ?? this.code,
      headers: headers ?? this.headers,
      body: body ?? this.body,
    );
  }

  @override
  List<Object?> get props => [code, headers, body];
}
