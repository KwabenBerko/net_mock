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

  @override
  List<Object?> get props => [code, headers, body];
}
