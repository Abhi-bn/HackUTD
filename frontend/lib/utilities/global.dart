import 'package:frontend/utilities/emergencies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static String djangoUrl = "http://127.0.0.1:8000";
  static String homePage = "$djangoUrl/home";
  static String loginPage = "$djangoUrl/user/login";
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

  static Future<void> updatePushT(String? token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var url =
        Uri.parse(Global.updatePushToken + 'id=' + sp.getInt("id").toString());

    Future.delayed(Duration.zero, () async {
      var req = await http.patch(url,
          body: {'id': sp.getInt("id").toString(), 'tokenid': token});
      if (req.statusCode != 200) return;
      print('All Good');
    });
  }
}
