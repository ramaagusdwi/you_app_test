import 'dart:convert';

class BaseHTTP {
  static Future<Map<String, String>> getAuthHeaders({String apiKey = ''}) async {
    //harcode username & password or api key cause astrology api trial for 14 days
    String username = '623859';
    String password = 'fb60f1e64b38a96c16e414de28138e15';

    print('Password: $password');

    return {
      'content-type': "application/json",
      'authorization': 'Basic ${base64Encode(utf8.encode('$username:$password'))}'
    };
  }
}
