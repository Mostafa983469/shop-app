import 'package:shared_preferences/shared_preferences.dart';

class Sharred {

  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putBool({
    required String key,
    required bool value,
})async{
    return await sharedPreferences?.setBool(key, value);
  }

  static dynamic Get({required key}){
    return sharedPreferences?.get(key);
  }

  static Future<bool> put({
    required String key,
    required dynamic value,
  })async{
    if(value is int) return await sharedPreferences!.setInt(key, value);
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }
  static Future<bool> delete({required key})
  async{
    return await sharedPreferences!.remove(key);
  }

}

