import 'dart:io';

/// Helper function to read resource files in the test/resources folder.
Future<String> readFromResources(String fileName) async {
  final file = File("./test/resources/$fileName");
  return await file.readAsString();
}
