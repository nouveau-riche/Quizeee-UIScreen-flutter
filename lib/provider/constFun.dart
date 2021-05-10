import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ConstFun {
  static void saveUserId(int userId, LocalStorage storage) async {
    await storage.ready;
    await storage.setItem("userId", userId);
  }

  static Future<dynamic> getKeyValue(String key, LocalStorage storage) async {
    await storage.ready;

    return await storage.getItem(key);
  }

  static Map<String, dynamic> reponseData(bool status, String msg) {
    return {"msg": msg, "status": status};
  }

  static bool checkStatus(http.Response result) {
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
