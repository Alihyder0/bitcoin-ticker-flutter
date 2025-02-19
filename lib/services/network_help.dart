import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelp {
  NetworkHelp({this.url});

  String? url;
  Future getData() async {
    Uri uri = Uri.parse(url!);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
