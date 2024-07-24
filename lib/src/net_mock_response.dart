import 'package:equatable/equatable.dart';

class NetMockResponse extends Equatable {
  final int code;
  final Map<String, String> headers;
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
