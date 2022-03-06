import 'package:shared_preferences/shared_preferences.dart';

class applicationSharedPreferences{

static SharedPreferences? _preferences;

static Future init()async{
_preferences = await SharedPreferences.getInstance();
}

    static Future setIntroVisibility(bool introValue) async =>
    await _preferences?.setBool('introValue',introValue);

    static bool? getIntroVisibility() =>
     _preferences?.getBool('introValue');

}