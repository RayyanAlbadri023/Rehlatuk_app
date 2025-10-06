import 'package:flutter/material.dart';
import 'details.dart'; // لو تستخدم صفحة تفاصيل لاحقاً

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  // 🔹 القائمة الثابتة للعناصر (السلة)
  static final List<Map<String, dynamic>> _cartItems = [];

  // 🔹 إضافة عنصر للسلة
  static void addToCart(Map<String, dynamic> place) {
    if (!isItemInCart(place['name'])) {
      _cartItems.add(place);
    }
  }

  // 🔹 حذف عنصر بالاسم
  static void removeFromCartByName(String name) {
    _cartItems.removeWhere((item) => item['name'] == name);
  }

  // 🔹 التحقق إذا العنصر موجود
  static bool isItemInCart(String name) {
    return _cartItems.any((item) => item['name'] == name);
  }

  // 🔹 إرجاع قائمة العناصر
  static List<Map<String, dynamic>> get cartItems => _cartItems;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // 🔹 حذف عنصر مع تحديث الواجهة
  void _removeItem(int index, String name) {
    setState(() {
      CartPage._cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$name removed from cart")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // لتفقد القيم أثناء التشغيل
    print("🛒 Cart Items: ${CartPage._cartItems}");

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🔹 خلفية الصفحة
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/car.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 زر الرجوع
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF160948)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // 🔹 محتوى السلة
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 16, right: 16),
            child: CartPage._cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty 🛍️",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: CartPage._cartItems.length,
                    itemBuilder: (context, index) {
                      final place = CartPage._cartItems[index];

                      // 🔹 تأكيد أن القيم ليست null
                      final imagePath =
                          (place['image'] ?? 'assets/default.jpg') as String;
                      final name = (place['name'] ?? 'Unknown place') as String;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Stack(
                          children: [
                            // 🩵 كرت العنصر
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      imagePath,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF160948),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 🔴 زر الحذف
                            Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 18,
                                    color: Color(0xFF160948),
                                  ),
                                  onPressed: () => _removeItem(index, name),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
