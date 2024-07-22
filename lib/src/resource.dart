import 'dart:io';

Future<String> readFromResources(String fileName) async {
  final file = File("./test/resources/$fileName");
  return await file.readAsString();
}
