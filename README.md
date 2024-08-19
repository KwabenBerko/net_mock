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

To use `net_mock`, ensure you have the following:

1. Dart SDK `2.12.0` or later.
2. A Flutter or Dart project.

### Installation

Add `net_mock` to your pubspec.yaml:

```yaml
dependencies:
  net_mock: ^1.0.2
```

Then, run `flutter pub get` to install the package.

## Usage

### Basic Setup

Here's a basic example of how to use `net_mock` to mock a GET request in a test:

```dart
void main() {
  late NetMock netMock;
  late NumberRepository sut;

  setUp(() {
    netMock = NetMock();
    sut = NumberRepository(client: netMock.client);
  });

  test(
    "should return random fact for number",
        () async {
      netMock.addMock(
        request: NetMockRequest(
          url: Uri.parse("http://numbersapi.com/42"),
          method: Method.get,
        ),
        response: NetMockResponse(
          code: 200,
          body: "42 is the number of US gallons in a barrel of oil.",
        ),
      );

      final result = await sut.getFactForNumber(number: 42);

      expect(
        result,
        equals("42 is the number of US gallons in a barrel of oil."),
      );
    },
  );
}

```
