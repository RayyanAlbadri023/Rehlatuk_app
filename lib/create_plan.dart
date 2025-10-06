import 'package:flutter/material.dart';
import 'date.dart';
import 'cart.dart';
import 'map_page.dart';

class SelectDis extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems; // يجب أن تكون dynamic أو String حسب كودك
  const SelectDis({super.key, required this.cartItems});

  @override
  State<SelectDis> createState() => _SelectDisState();
}


class _SelectDisState extends State<SelectDis> {
  final Color backgroundColor = const Color(0xFF16014A);

  // افترض أن لديك قائمة الأماكن هنا أو جلبها من مكان آخر
  List<Map<String, dynamic>> places = [
    {'title': 'Al Alam Palace', 'path': 'assets/qasr.jpg'},
    {'title': 'Mutrah Corniche', 'path': 'assets/beach.jpg'},
    {'title': 'Nizwa Souq', 'path': 'assets/nizwa.jpg'},
    {'title': 'Jabal Haat', 'path': 'assets/hatt.jpg'},
  ];

  bool isInCart(String title) =>
      widget.cartItems.any((item) => item['title'] == title);

  void addToCart(Map<String, dynamic> place) {
    if (!isInCart(place['title']!)) {
      setState(() {
        widget.cartItems.add(place);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${place['title']} added"),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void removeFromCart(String title) {
    setState(() {
      widget.cartItems.removeWhere((item) => item['title'] == title);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title removed"),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "Create a Trip Plan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: places.isEmpty
            ? const Center(
                child: Text(
                  "No places left",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: (places.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        int firstIndex = index * 2;
                        int secondIndex = firstIndex + 1;
                        final place1 = places[firstIndex];
                        final place2 = secondIndex < places.length
                            ? places[secondIndex]
                            : null;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Day ${index + 1}",
                                  style: const TextStyle(
                                    color: Color(0xFF16014A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // أول صورة
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              place1['path'],
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  removeFromCart(place1['title']),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.redAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(4),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // ثاني صورة
                                    if (place2 != null)
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                place2['path'],
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
                                                onTap: () => removeFromCart(
                                                    place2['title']),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.redAccent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                    // زر + لإضافة
                                    GestureDetector(
                                      onTap: () {
                                        addToCart(place1);
                                        if (place2 != null) addToCart(place2);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isInCart(place1['title'])
                                              ? Colors.grey
                                              : Colors.blueAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      place1['title'],
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    if (place2 != null)
                                      Text(
                                        place2['title'],
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // زر Apply Now
                  ElevatedButton(
                    onPressed: widget.cartItems.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (_) => MapPage(items: widget.cartItems),

                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.cartItems.isEmpty
                          ? Colors.grey
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    child: Text(
                      "Apply Now",
                      style: TextStyle(
                        color: widget.cartItems.isEmpty
                            ? Colors.black54
                            : backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
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
