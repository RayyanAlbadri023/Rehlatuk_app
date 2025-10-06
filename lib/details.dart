// details.dart

import 'package:flutter/material.dart';
import 'comment_page.dart';
import 'map_page.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> placeData;

  const DetailsPage({super.key, required this.placeData});

  @override
  Widget build(BuildContext context) {
    // تجهيز البيانات مع التحقق من null
    final String name = placeData["name"] ?? "Place Details";
    final String? imagePath = placeData["image"]; // nullable
    final String description =
        placeData["description"] ?? "No information available for this place.";
    final double rating =
        placeData["rating"] is num ? (placeData["rating"] as num).toDouble() : 0.0;
    final List<Map<String, String>> initialComments = (placeData["comments"] as List?)
            ?.map((comment) => (comment as Map<String, dynamic>).cast<String, String>())
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: const Color(0xFF160948),
      appBar: AppBar(
        backgroundColor: const Color(0xFF160948),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image of the place
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.white, size: 50),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Description text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            // Rating and comment row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 28),
                      const SizedBox(width: 5),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Comment icon
                  IconButton(
                    icon: const Icon(Icons.comment, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentPage(
                            placeName: name,
                            initialComments: initialComments,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // View Location Map Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF160948),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapPage(placeName: name),
                    ),
                  );
                },
                icon: const Icon(Icons.location_on_outlined),
                label: const Text(
                  "View Location Map",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
