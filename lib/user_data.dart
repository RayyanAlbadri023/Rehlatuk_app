// lib/user_data.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final String name;
  final String email;
  final String phone;
  final String language;
  final ThemeMode themeMode;
  final String? profileImagePath;

  UserData({
    required this.name,
    required this.email,
    required this.phone,
    this.language = "English",
    this.themeMode = ThemeMode.system,
    this.profileImagePath,
  });

  // Convenience constructor for initial/default user
  factory UserData.initial() {
    return UserData(name: '', email: '', phone: '', language: 'English', themeMode: ThemeMode.system);
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  File? get profileImage => profileImagePath != null && profileImagePath!.isNotEmpty
      ? File(profileImagePath!)
      : null;

  UserData copyWith({
    String? name,
    String? email,
    String? phone,
    String? language,
    ThemeMode? themeMode,
    String? profileImagePath,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'language': language,
      'themeMode': themeMode.index,
      'profileImagePath': profileImagePath,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      language: map['language'] ?? 'English',
      themeMode: ThemeMode.values[map['themeMode'] ?? ThemeMode.system.index],
      profileImagePath: map['profileImagePath'],
    );
  }

  String toJson() => json.encode(toMap());
  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));
}

// Global notifiers
final ValueNotifier<UserData> userDataNotifier = ValueNotifier<UserData>(UserData.initial());
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

// Save user data to SharedPreferences
Future<void> saveUserData(UserData data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userData', data.toJson());
}

// Load user data from SharedPreferences and return UserData
Future<UserData> loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = prefs.getString('userData');
  if (jsonData != null && jsonData.isNotEmpty) {
    try {
      final data = UserData.fromJson(jsonData);
      // apply loaded values to notifiers as well
      userDataNotifier.value = data;
      themeNotifier.value = data.themeMode;
      return data;
    } catch (e) {
      // fallback to initial if corrupted
      final initial = UserData.initial();
      userDataNotifier.value = initial;
      themeNotifier.value = initial.themeMode;
      return initial;
    }
  } else {
    final initial = UserData.initial();
    userDataNotifier.value = initial;
    themeNotifier.value = initial.themeMode;
    return initial;
  }
}
