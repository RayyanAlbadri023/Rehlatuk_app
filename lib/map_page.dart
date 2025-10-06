import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  final List<Map<String, dynamic>>? items;
  final String? placeName;

  const MapPage({
    super.key,
    this.items,
    this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    final places = items ?? []; // إذا كانت null نعطيها قائمة فاضية

    return Scaffold(
      backgroundColor: const Color(0xFF160948), // الخلفية الزرقاء الداكنة
      appBar: AppBar(
        backgroundColor: const Color(0xFF160948),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          placeName ?? "Map View",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Selected Places:",
                style: TextStyle(
                  color: Color(0xFF160948),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              if (places.isEmpty)
                const Text(
                  "No places selected",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )
              else
                ...places.map(
                  (place) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      place['name'] ?? 'Unknown Place',
                      style: const TextStyle(
                        color: Color(0xFF160948),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 25),
              const Text(
                "🗺️ Map will appear here",
                style: TextStyle(
                  color: Color(0xFF160948),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
