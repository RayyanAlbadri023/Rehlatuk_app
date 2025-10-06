import 'package:flutter/material.dart';
import 'country.dart';
import 'settings_page.dart'; // ✅ استيراد صفحة الإعدادات

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 2) {
      // ✅ Trip Plan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountryPage()),
      );
    } else if (index == 3) {
      // ✅ Settings Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 الخلفية
          Positioned.fill(
            child: Image.asset(
              "assets/car.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 المحتوى
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Color(0xFF160948),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Discover New Destination",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🔹 زر بدء الرحلة
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()),
                          );
                        },
                        child: const Text(
                          "Start your new trip",
                          style: TextStyle(
                            color: Color(0xFF160948),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Hot top trip plans",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 15),

                    Expanded(
                      child: ListView(
                        children: [
                          _tripCard("Muscat - Oman", "assets/muscat.jpg"),
                          const SizedBox(height: 15),
                          _tripCard("Bangkok - Thailand", "assets/bangkok.jpg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // 🔹 شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[400],
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

  // 🔹 كارت الرحلات
  Widget _tripCard(String name, String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 10,
            left: 15,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
