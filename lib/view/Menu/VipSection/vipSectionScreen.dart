import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipSectionScreen extends StatelessWidget {
  const VipSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'VIP Section Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
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
              _header("✧ VIP MANAGEMENT ✧"),
              const SizedBox(height: 20),
              _section("General Settings", [
                _ButtonData(
                  Icons.monetization_on,
                  "Game Rates",
                  () => Get.snackbar("Tapped", "Game Rates"),
                ),
                _ButtonData(
                  Icons.settings,
                  "User Configuration",
                  () => Get.snackbar("Tapped", "User Configuration"),
                ),
                _ButtonData(
                  Icons.analytics,
                  "Sell Report",
                  () => Get.snackbar("Tapped", "Sell Report"),
                ),
              ]),
              _section("Bazaar Management", [
                _ButtonData(
                  Icons.add_business,
                  "Add Bazaar",
                  () => Get.snackbar("Tapped", "Add Bazaar"),
                ),
                _ButtonData(
                  Icons.store,
                  "Bazaar List",
                  () => Get.snackbar("Tapped", "Bazaar List"),
                ),
              ]),
              _section("Game Reports", [
                _ButtonData(
                  Icons.onetwothree,
                  "Single Digit",
                  () => Get.snackbar("Tapped", "Single Digit"),
                ),
                _ButtonData(
                  Icons.numbers,
                  "Jodi Digit",
                  () => Get.snackbar("Tapped", "Jodi Digit"),
                ),
                _ButtonData(
                  Icons.looks_one,
                  "Single Panna",
                  () => Get.snackbar("Tapped", "Single Panna"),
                ),
                _ButtonData(
                  Icons.looks_two,
                  "Double Panna",
                  () => Get.snackbar("Tapped", "Double Panna"),
                ),
                _ButtonData(
                  Icons.looks_3,
                  "Triple Panna",
                  () => Get.snackbar("Tapped", "Triple Panna"),
                ),
                _ButtonData(
                  Icons.hive,
                  "Half Sangam",
                  () => Get.snackbar("Tapped", "Half Sangam"),
                ),
                _ButtonData(
                  Icons.join_full,
                  "Full Sangam",
                  () => Get.snackbar("Tapped", "Full Sangam"),
                ),
              ]),
              _section("Winning Reports", [
                _ButtonData(
                  Icons.emoji_events,
                  "Single Digit",
                  () => Get.snackbar("Tapped", "Single Digit"),
                ),
                _ButtonData(
                  Icons.emoji_events,
                  "Jodi Digit",
                  () => Get.snackbar("Tapped", "Jodi Digit"),
                ),
                _ButtonData(
                  Icons.emoji_events,
                  "Single Panna",
                  () => Get.snackbar("Tapped", "Single Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events,
                  "Double Panna",
                  () => Get.snackbar("Tapped", "Double Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events,
                  "Triple Panna",
                  () => Get.snackbar("Tapped", "Triple Panna"),
                ),
                _ButtonData(
                  Icons.emoji_events,
                  "Half Sangam",
                  () => Get.snackbar("Tapped", "Half Sangam"),
                ),
                _ButtonData(
                  Icons.emoji_events,
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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepPurple[100]!),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color:  Color(0xFF283593),
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<_ButtonData> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:  Color(0xFF283593),
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
                  .map((btn) => _vipMenuButton(btn.icon, btn.label, btn.onTap))
                  .toList(),
        ),
      ],
    );
  }

  Widget _vipMenuButton(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor:  Color(0xFF283593),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
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
                  color: Color(0xFF1A237E),
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
