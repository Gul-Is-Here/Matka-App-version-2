import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Replace with actual screens
import 'MainRelatedScreen/gameTypeScreen.dart';

class MainMarketsScreen extends StatelessWidget {
  const MainMarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF283593),
        title: Text(
          'Main Markets Admin',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
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
              _header("Market Management"),
              const SizedBox(height: 20),
              _section("General Operations", [
                _ButtonData(
                  Icons.casino_outlined,
                  "Game Type",
                  () => Get.to(() => GameRateScreen()),
                ),
                _ButtonData(
                  Icons.announcement_outlined,
                  "Declare Result",
                  () => Get.snackbar("Navigate", "Declare Result"),
                ),
                _ButtonData(
                  Icons.list_alt_outlined,
                  "Announced Result",
                  () => Get.snackbar("Navigate", "Announced Result"),
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
                  Icons.onetwothree,
                  "Single Digit",
                  () => Get.snackbar("Tapped", "Single Digit"),
                ),
                _ButtonData(
                  Icons.numbers_outlined,
                  "Jodi Digit",
                  () => Get.snackbar("Tapped", "Jodi Digit"),
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
                _ButtonData(
                  Icons.hive_outlined,
                  "Half Sangam",
                  () => Get.snackbar("Tapped", "Half Sangam"),
                ),
                _ButtonData(
                  Icons.join_full_outlined,
                  "Full Sangam",
                  () => Get.snackbar("Tapped", "Full Sangam"),
                ),
              ]),
              _section("Winning Reports", [
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Single Digit",
                  () => Get.snackbar("Tapped", "Single Digit"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Jodi Digit",
                  () => Get.snackbar("Tapped", "Jodi Digit"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Single Panna",
                  () => Get.snackbar("Tapped", "Single Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Double Panna",
                  () => Get.snackbar("Tapped", "Double Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Triple Panna",
                  () => Get.snackbar("Tapped", "Triple Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Half Sangam",
                  () => Get.snackbar("Tapped", "Half Sangam"),
                ),
                _ButtonData(
                  Icons.emoji_events_outlined,
                  "Full Sangam",
                  () => Get.snackbar("Tapped", "Full Sangam"),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFF283593),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF283593)),
        ),
        child: Text(
          title,
          style: TextStyle(
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
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              buttons
                  .map((btn) => _marketButton(btn.icon, btn.label, btn.onTap))
                  .toList(),
        ),
      ],
    );
  }

  Widget _marketButton(IconData icon, String label, VoidCallback onTap) {
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: Color(0xFF283593)),
              ),
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
