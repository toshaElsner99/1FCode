import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._internal();
  static final StorageService instance = StorageService._internal();

  Future<SharedPreferences> _prefs() async => await SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async {
    final prefs = await _prefs();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _prefs();
    return prefs.getString(key);
  }

  Future<void> remove(String key) async {
    final prefs = await _prefs();
    await prefs.remove(key);
  }

  // Convenience: replace a stored file path by deleting the existing file if present
  Future<void> replaceStoredFilePath({required String key, required String newPath}) async {
    final prefs = await _prefs();
    final existing = prefs.getString(key);
    if (existing != null && existing.isNotEmpty) {
      final file = File(existing);
      if (await file.exists()) {
        try { await file.delete(); } catch (_) {}
      }
    }
    await prefs.setString(key, newPath);
  }
}


