import 'package:shared_preferences/shared_preferences.dart';

class applicationSharedPreferences{

  static SharedPreferences? _preferences;
  static const _switchKey = "isSwitch";
  //final _preferences = SharedPreferences.getInstance() ;


  static Future init()async=>
    _preferences = await SharedPreferences.getInstance();


    static Future setIntroVisibility(bool introValue) async =>
      await _preferences?.setBool('introValue',introValue);

    static bool? getIntroVisibility() =>
     _preferences?.getBool('introValue');

    static Future setCustomerOrTailor(String s)async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return await pref.setString(_switchKey, s);
    }


  static void getustomerOrTailor() async{
    _preferences?.getString(_switchKey);
  }
    static String? getCustomerOrTailor() {
      return _preferences?.getString(_switchKey);
    }

     static Future setTemplateAddOrRemove(List<String> s) async=>
       await _preferences?.setStringList(_switchKey,s);

    static List<String>? getTemplateAddOrRemove()=>
        _preferences?.getStringList(_switchKey);

}