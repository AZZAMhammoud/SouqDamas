import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Check for admin account
      if (email == 'abohadar688@gmail.com' && password == 'Moh678med') {
        _currentUser = User(
          id: '1',
          name: 'مدير سوق الشام',
          email: email,
          role: 'admin',
        );
        await _saveUserToPrefs();
        _isLoading = false;
        notifyListeners();
        return true;
      }

      // Check for demo user account
      if (email == 'user@test.com' && password == '123456') {
        _currentUser = User(
          id: '2',
          name: 'مستخدم تجريبي',
          email: email,
          role: 'user',
        );
        await _saveUserToPrefs();
        _isLoading = false;
        notifyListeners();
        return true;
      }

      // Check for seller account
      if (email == 'seller@test.com' && password == '123456') {
        _currentUser = User(
          id: '3',
          name: 'بائع تجريبي',
          email: email,
          role: 'seller',
        );
        await _saveUserToPrefs();
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        role: 'user',
      );

      await _saveUserToPrefs();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> loadUserFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id');
      final userName = prefs.getString('user_name');
      final userEmail = prefs.getString('user_email');
      final userRole = prefs.getString('user_role');

      if (userId != null && userName != null && userEmail != null && userRole != null) {
        _currentUser = User(
          id: userId,
          name: userName,
          email: userEmail,
          role: userRole,
        );
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _saveUserToPrefs() async {
    if (_currentUser != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', _currentUser!.id);
      await prefs.setString('user_name', _currentUser!.name);
      await prefs.setString('user_email', _currentUser!.email);
      await prefs.setString('user_role', _currentUser!.role);
    }
  }
}

