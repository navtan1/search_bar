import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_bar/api_routes/api_routes.dart';

class SignUpServices {
  static Future<bool> getSignUp({Map<String, dynamic>? reqBody}) async {
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.post(Uri.parse(ApiRoutes.signUp),
        body: reqBody, headers: header);

    var result = jsonDecode(response.body);
    print('Responce=====>>>>>${jsonDecode(response.body)}');
    return result['status'];
  }
}
