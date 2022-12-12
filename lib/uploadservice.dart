import 'dart:convert';


import 'package:http/http.dart' as http;

Future<String> uploadPhotos(String file) async {
  Uri postUri = Uri.parse('http://localhost:3000/profile/');
  http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', file);
  request.files.add(multipartFile);
  http.StreamedResponse response = await request.send();
  print(response.statusCode);

  return response.toString();
}
