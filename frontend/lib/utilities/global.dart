import 'package:frontend/utilities/emergencies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Global {
  static String djangoUrl = "http://127.0.0.1:8000";
  static String homePage = "$djangoUrl/home";
  static String loginPage = "$djangoUrl/login";
  static String updatePushToken = "$djangoUrl/user?";
  static String LoadEmergencies = "$djangoUrl/emergency/all?";
  static var headersList = {
    'Accept': '*/*',
    'Content-Type': 'application/json'
  };

  static Future<List<Emergencies>> loadEmergency(int type) async {
    var url = Uri.parse(Global.LoadEmergencies + 'type=' + type.toString());
    var req = await http.get(url, headers: headersList);
    if (req.statusCode != 200) return List.empty();
    List<Emergencies> data = List.empty(growable: true);
    var raw = json.decode(req.body)['data'];
    for (int i = 0; i < raw.length; i++) {
      data.add(Emergencies.fromJson(raw[i]));
    }
    return data;
  }

  static Future<void> updatePushT(int id, String? token) async {
    var url = Uri.parse(Global.updatePushToken + 'id=' + id.toString());
    var req = await http
        .patch(url, headers: headersList, body: {'id': id, 'tokenid': token});

    if (req.statusCode != 200) return;
    print('All Good');
  }
}
