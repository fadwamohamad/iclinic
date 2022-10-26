import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._();
  late SharedPreferences _sharedPreferences;

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  SharedPreferences getSharedPreferences() {
    return _sharedPreferences;
  }

  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  void addStringToSF(String key, String value) async {
    SharedPreferences prefs = await getInstance();
    prefs.setString(key, value);
  }

  Future fAddStringToSF(String key, String value) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setString(key, value);
  }

  void addIntToSF(String key, int value) async {
    SharedPreferences prefs = await getInstance();
    prefs.setInt(key, value);
  }

  void addDoubleToSF(String key, double value) async {
    SharedPreferences prefs = await getInstance();
    prefs.setDouble(key, value);
  }

  void addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await getInstance();
    prefs.setBool(key, value);
  }

  void addObjectToSF(String key, Object value) async {
    SharedPreferences prefs = await getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  Future fAddObjectToSF(String key, Object value) async {
    SharedPreferences prefs = await getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  void addObject(String key, Object value) {
    SharedPreferences prefs = getSharedPreferences();
    prefs.setString(key, jsonEncode(value));
  }

  getStringSF(String key) {
    String? stringValue = _sharedPreferences.getString(key);

    return stringValue;
  }

  String getStringSFWithDefault(String key, String dfault) {
    return _sharedPreferences.getString(key) ?? dfault;
  }

  String getString(String key) {
    return getSharedPreferences().getString(key) ?? "";
  }

  Future<dynamic> getBoolSF(String key) async {
    SharedPreferences prefs = await getInstance();
    bool? boolValue = prefs.getBool(key);

    return boolValue != null ? boolValue : false;
  }

  bool getBool(String key) {
    bool? boolValue = getSharedPreferences().getBool(key);

    return boolValue ?? false;
  }

  Future<dynamic> getIntValuesSF(String key) async {
    SharedPreferences prefs = await getInstance();
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  int getInt(String key) {
    int? intValue = getSharedPreferences().getInt(key);
    return intValue ?? -1;
  }

  Future<dynamic> getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await getInstance();
    double? doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

  double getDouble(String key) {
    double? doubleValue = getSharedPreferences().getDouble(key);
    return doubleValue ?? 0.0;
  }

  Future<dynamic> removeValue(String key) async {
    SharedPreferences prefs = await getInstance();
    prefs.remove(key);
  }

  Future<dynamic> removeAllValues() async {
    SharedPreferences prefs = await getInstance();
    prefs.clear();
  }

  Future<dynamic> containsKey(String key) async {
    SharedPreferences prefs = await getInstance();
    bool checkValue = prefs.containsKey(key);

    return checkValue;
  }

  // CustomerModel getUser() {
  //    Map<String, dynamic> map;
  //   final String? userStr =
  //       getSharedPreferences().getString(Constants.user_info);
  //   if (userStr != null) {
  //     map = jsonDecode(userStr) as Map<String, dynamic>;
  //     print(map);
  //     dynamic object;
  //       object = CustomerModel.fromJson(map);
  //     return object;
  //   } else {
  //     return CustomerModel();
  //   }
  // }

  // ResponseSetting? getSetting() {
  //   Map<String, dynamic> map;
  //   final String? userStr =
  //       getSharedPreferences().getString(Constants.setting_SharedPref);
  //   if (userStr != null) {
  //     map = jsonDecode(userStr) as Map<String, dynamic>;
  //     final ResponseSetting object = ResponseSetting.fromJson(map);
  //     return object;
  //   } else {
  //     return null;
  //   }
  // }

  Future<bool> get isLoggedIn async {
    SharedPreferences _sharedPreferences = await getInstance();
    return _sharedPreferences.getBool('logged_in') ?? false;
  }

  Future<int> get notiCounter async {
    SharedPreferences _sharedPreferences = await getInstance();
    return _sharedPreferences.getInt('count') ?? 0;
  }

  String get token {
    return getSharedPreferences().getString(Constants.token) ?? '';
  }

  Future<void> logOut() async {
    // SharedPreferences _sharedPreferences = await getInstance();
    UserPreferences().addBoolToSF(Constants.isLogged, false);
    //UserPreferences().addIntToSF(Constants.cart_count,  0);

    UserPreferences().removeValue(Constants.user_info);
    UserPreferences().removeValue(Constants.token);
    // await _sharedPreferences.clear();
  }
  // ResponseSetting? getSetting() {
  //   Map<String, dynamic> map;
  //   String? userStr = getSharedPreferences().getString(Constants.setting_SharedPref);
  //   print("$userStr");
  //   if (userStr != null) {
  //     map = jsonDecode(userStr) as Map<String, dynamic>;
  //     final ResponseSetting object = ResponseSetting.fromJson(map);
  //     return object;
  //   } else {
  //     return null;
  //   }
  // }
}
