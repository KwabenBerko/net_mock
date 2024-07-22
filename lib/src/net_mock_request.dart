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

  @override
  List<Object?> get props => [url, method, headers, body];
}
