import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  String? _token;
  bool _isAuth = false;

  bool get isAuth => _isAuth;
  String? get token => _token;

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString('token');

    if (storedToken != null) {
      _token = storedToken;
      _isAuth = true;
      notifyListeners();
    }
  }

  Future<void> login(String token) async {
    _token = token;
    _isAuth = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> logout() async {
    _token = null;
    _isAuth = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}