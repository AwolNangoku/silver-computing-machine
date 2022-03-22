import 'package:http/http.dart' as http;

Future serverPut(String url, http.MultipartFile data) async {
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(data);
  var res = await request.send();
  return res;
}
