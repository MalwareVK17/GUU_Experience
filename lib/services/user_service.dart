import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _nameKey = 'user_name';
  static const String _emailKey = 'user_email';
  static const String _phoneKey = 'user_phone';
  static const String _profileImageKey = 'profile_image_path';

  // Save user data
  static Future<void> saveUserData({
    required String name,
    required String email,
    required String phone,
    String? profileImagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_nameKey, name),
      prefs.setString(_emailKey, email),
      prefs.setString(_phoneKey, phone),
      if (profileImagePath != null)
        prefs.setString(_profileImageKey, profileImagePath),
    ]);
  }

  // Save profile image path
  static Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }

  // Get user data
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_nameKey) ?? '',
      'email': prefs.getString(_emailKey) ?? '',
      'phone': prefs.getString(_phoneKey) ?? '',
      'profileImagePath': prefs.getString(_profileImageKey) ?? '',
    };
  }

  // Get profile image path
  static Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }
}
