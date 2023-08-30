import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
//===============Keys for session=============//

  //===========Initialize and inject============///
  static Future<bool> initSessionManager() async {
    var _prefs = await SharedPreferences.getInstance();
    Get.put(_prefs);
    return true;
  }

  //-----------Cart Count--------------//

  static bool isProfileFilled() {
    SharedPreferences _pref = Get.find();
    if (_pref.containsKey("email") ||
        _pref.containsKey("gender") ||
        _pref.containsKey("age") ||
        _pref.containsKey("height") ||
        _pref.containsKey("weight") ||
        _pref.containsKey("education") ||
        _pref.containsKey("country")) {
      if (_pref.getString("email") == "" ||
          _pref.getString("gender") == "" ||
          _pref.getString("age") == "" ||
          _pref.getString("height") == "" ||
          _pref.getString("weight") == "" ||
          _pref.getString("education") == "" ||
          _pref.getString("country") == "")
        return false;
      else
        return true;
    } else
      return false;
  }

//--------------------------------------//
}
