import 'package:equatable/equatable.dart';
import 'package:net_mock/src/net_mock_request.dart';
import 'package:net_mock/src/net_mock_response.dart';

/// Represents a mapping between an HTTP request and its corresponding
/// response in `net_mock`.
class NetMockRequestResponse extends Equatable {
  final NetMockRequest request;
  final NetMockResponse response;

  NetMockRequestResponse({required this.request, required this.response});

  @override
  List<Object?> get props => [request, response];
}
