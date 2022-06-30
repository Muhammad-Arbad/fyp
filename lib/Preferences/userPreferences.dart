import 'package:shared_preferences/shared_preferences.dart';

class ApplicationSharedPreferences{

  static SharedPreferences? _preferences;
  static const _switchKey = "isSwitch";
  //final _preferences = Preferences.getInstance() ;


  static Future init()async=>
    _preferences = await SharedPreferences.getInstance();


    static Future setIntroVisibility(bool introValue) async =>
      await _preferences?.setBool('introValue',introValue);

    static bool? getIntroVisibility() =>
     _preferences?.getBool('introValue');

    static Future setCustomerOrTailor(String s)async {
      return await _preferences?.setString(_switchKey, s);
    }


    static String? getCustomerOrTailor() {
      return _preferences?.getString(_switchKey);
    }

    static Future setTemplateAddOrRemove(List<String>? s) async=>
       await _preferences?.setStringList(_switchKey,s!);

    static List<dynamic>? getTemplateAddOrRemove()=>
        _preferences!.getStringList(_switchKey);
}