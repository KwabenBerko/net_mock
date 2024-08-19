# net_mock

`net_mock` is a Dart package that streamlines the process of mocking HTTP requests in your tests.
Inspired by [NetMock](https://github.com/DenisBronx/NetMock), it extends the `http.MockClient`
package by adding a layer of syntactic sugar. This makes it even more straightforward to define and
manage expected requests and responses, allowing you to focus on writing clear and concise tests.

## Features

1. Mock HTTP requests and responses for all HTTP methods.
2. Simplified API for setting up mocks.

## Getting started

### Prerequisites

To use `NetMock`, ensure you have the following:

1. Dart SDK `2.12.0` or later.
2. A Flutter or Dart project.

### Installation

Add `NetMock` to your pubspec.yaml:

```yaml
dependencies:
  net_mock: ^1.0.0
```

Then, run `flutter pub get` to install the package.

## Usage

### Basic Setup

Here's a basic example of how to use NetMock to mock a GET request in a test:

```dart

void main() {
  late NetMock netMock;

  setUp(() {
    netMock = NetMock();
  });

  tearDown(() {
    netMock.close();
  });

  test("your test", () async {
    final url = Uri.parse('https://google.com');
    // Define the request and response
    final request = NetMockRequest(url: url, method: Method.get);
    final response = NetMockResponse(
      code: 200,
      body: '{"message": "Hello, world!"}',
    );
    // Add the mock to NetMock
    netMock.addMock(request, response);

    // Replace YourSystemUnderTest with the actual class you are testing
    final sut = YourSystemUnderTest(client: netMock.client);
  });
}


```
