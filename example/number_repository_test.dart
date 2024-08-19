import 'package:net_mock/net_mock.dart';
import 'package:net_mock/src/method.dart';
import 'package:net_mock/src/net_mock_request.dart';
import 'package:net_mock/src/net_mock_response.dart';
import 'package:test/test.dart';

import 'user.dart';
import 'number_repository.dart';

void main() {
  late NetMock netMock;
  late UserRepository sut;

  setUp(() {
    netMock = NetMock();
    sut = UserRepository(client: netMock.client);
  });

  test(
    "should return users",
    () async {
      final user = "KwabenBerko";
      final expected = [
        User(firstName: "Peter", lastName: "Parker"),
        User(firstName: "Eobard", lastName: "Thawne"),
      ];
      netMock.addMock(
        request: NetMockRequest(
          url: Uri.parse("https://api.github.com/users/$user/repos"),
          method: Method.get,
        ),
        response: NetMockResponse(code: 200, body: ),
      );

      final result = await sut.getUsers();

      expect(result, equals(expected));
    },
  );
}
