import 'dart:io';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'notification_page.dart';
import 'theme_mode_page.dart';
import 'language_page.dart';
import 'about_page.dart';
import 'feedback_page.dart';
import 'login_screen.dart';
import 'user_data.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 3; // ✅ Settings icon is active (index 3)

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/HomePage');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/smart');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/list');
        break;
      case 3:
        break; // Stay in Settings
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF160948), // 🔹 خلفية زرقاء موحدة
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF160948),
        centerTitle: true,
        elevation: 0,
      ),
      body: ValueListenableBuilder<UserData>(
        valueListenable: userDataNotifier,
        builder: (context, userData, _) {
          final lang = userData.language;

          return Column(
            children: [
              // 🔹 الهيدر
              Container(
                color: const Color(0xFF160948),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: userData.profileImage != null
                          ? FileImage(userData.profileImage!)
                          : null,
                      child: userData.profileImage == null
                          ? const Icon(Icons.person,
                              size: 40, color: Color(0xFF160948))
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.name.isNotEmpty
                              ? userData.name
                              : (lang == "Arabic" ? "مرحباً" : "Welcome"),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          userData.email.isNotEmpty
                              ? userData.email
                              : (lang == "Arabic"
                                  ? "أدخل بريدك"
                                  : "Add email"),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🔹 قائمة الخيارات
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    MenuItem(
                      icon: Icons.person,
                      title: lang == "Arabic"
                          ? "الملف الشخصي"
                          : "Profile Settings",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      ),
                    ),
                    MenuItem(
                      icon: Icons.notifications_off,
                      title:
                          lang == "Arabic" ? "الإشعارات" : "Notifications",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationPage()),
                      ),
                    ),
                    MenuItem(
                      icon: Icons.thumb_up,
                      title: lang == "Arabic" ? "التقييم" : "Feedback",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FeedbackPage()),
                      ),
                    ),
                    MenuItem(
                      icon: Icons.info,
                      title:
                          lang == "Arabic" ? "معلومات عنا" : "About Us",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutPage()),
                      ),
                    ),
                    MenuItem(
                      icon: Icons.language,
                      title: lang == "Arabic" ? "اللغة" : "Language",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguagePage()),
                      ),
                    ),
                    MenuItem(
                      icon: Icons.color_lens,
                      title:
                          lang == "Arabic" ? "وضع العرض" : "Theme Mode",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ThemeModePage()),
                      ),
                    ),
                    const MenuItem(icon: Icons.lock, title: "Reset Password"),
                    MenuItem(
                      icon: Icons.logout,
                      title:
                          lang == "Arabic" ? "تسجيل الخروج" : "Log Out",
                      onTap: () =>
                          _showLogoutDialog(context, lang),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF160948),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 28,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }
}

// 🔹 عنصر القائمة
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}

// 🔹 نافذة تسجيل الخروج
void _showLogoutDialog(BuildContext context, String lang) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                lang == "Arabic"
                    ? "هل أنت متأكد من تسجيل الخروج؟"
                    : "Are you sure you want to Logout?",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF160948),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Yes sure",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
