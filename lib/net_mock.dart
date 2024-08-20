/// `net_mock` is a Dart package that streamlines the process of mocking HTTP requests in your tests.
/// Inspired by [NetMock](https://github.com/DenisBronx/NetMock), it extends the `http.MockClient`
/// package by adding a layer of syntactic sugar. This makes it even more straightforward to define and
/// manage expected requests and responses, allowing you to focus on writing clear and concise tests.
library net_mock;

export 'src/net_mock.dart';
export 'src/net_mock_request.dart';
export 'src/net_mock_response.dart';
export 'src/method.dart';
export 'src/resource.dart';
