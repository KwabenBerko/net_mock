import 'package:http/http.dart';

import 'user.dart';

class UserRepository {
  final Client client;

  UserRepository({required this.client});

  Future<List<User>> getUsers() async {
    return [];
  }
}
