import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StarlineScreen extends StatelessWidget {
  const StarlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Starline Admin',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF283593),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.snackbar(
                "Logout",
                "Logged out successfully",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header("Starline Dashboard"),
              const SizedBox(height: 20),
              _section("General Operations", [
                _ButtonData(
                  Icons.casino_outlined,
                  "Game Type",
                  () => Get.snackbar("Tapped", "Game Type"),
                ),
                _ButtonData(
                  Icons.announcement_outlined,
                  "Declare Result",
                  () => Get.snackbar("Tapped", "Declare Result"),
                ),
                _ButtonData(
                  Icons.list_alt_outlined,
                  "Announced Result",
                  () => Get.snackbar("Tapped", "Announced Result"),
                ),
              ]),
              _section("Bazaar Management", [
                _ButtonData(
                  Icons.add_business_outlined,
                  "Add Bazaar",
                  () => Get.snackbar("Tapped", "Add Bazaar"),
                ),
                _ButtonData(
                  Icons.store_outlined,
                  "Bazaar List",
                  () => Get.snackbar("Tapped", "Bazaar List"),
                ),
                _ButtonData(
                  Icons.access_time_outlined,
                  "Bazaar Time",
                  () => Get.snackbar("Tapped", "Bazaar Time"),
                ),
              ]),
              _section("Game Reports", [
                _ButtonData(
                  Icons.analytics_outlined,
                  "Customer Sell Report",
                  () => Get.snackbar("Tapped", "Customer Sell Report"),
                ),
                _ButtonData(
                  Icons.onetwothree,
                  "Single Digit",
                  () => Get.snackbar("Tapped", "Single Digit"),
                ),
                _ButtonData(
                  Icons.looks_one_outlined,
                  "Single Panna",
                  () => Get.snackbar("Tapped", "Single Panna"),
                ),
                _ButtonData(
                  Icons.looks_two_outlined,
                  "Double Panna",
                  () => Get.snackbar("Tapped", "Double Panna"),
                ),
                _ButtonData(
                  Icons.looks_3_outlined,
                  "Triple Panna",
                  () => Get.snackbar("Tapped", "Triple Panna"),
                ),
              ]),
              _section("Winning Reports", [
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Winning Reports",
                  () => Get.snackbar("Tapped", "Winning Reports"),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF283593), Color(0xFF283593)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF283593),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<_ButtonData> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.star_rate_rounded, color: Colors.deepPurple[400]),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF283593),
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              buttons
                  .map((btn) => _starlineButton(btn.icon, btn.label, btn.onTap))
                  .toList(),
        ),
      ],
    );
  }

  Widget _starlineButton(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: Color(0xFF283593),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Color(0xFF283593)),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF283593),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _ButtonData(this.icon, this.label, this.onTap);
}
