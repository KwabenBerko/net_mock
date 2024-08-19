import 'package:http/http.dart';

class NumberRepository {
  final Client client;

  NumberRepository({required this.client});

  Future<String> getFactForNumber({required int number}) async {
    final url = Uri.parse("http://numbersapi.com/$number");
    final response = await client.get(url);
    return response.body;
  }
}
