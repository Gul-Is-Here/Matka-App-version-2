import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GaliDisawarScreen extends StatelessWidget {
  const GaliDisawarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Gali Disawar Admin',
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
              _header("Dashboard Overview"),
              const SizedBox(height: 20),
              // _statCards(),
              const SizedBox(height: 20),
              _section("General Management", [
                _ButtonData(
                  Icons.casino,
                  "Game Type",
                  () => Get.snackbar("Tapped", "Game Type"),
                ),
                _ButtonData(
                  Icons.announcement,
                  "Declare Result",
                  () => Get.snackbar("Tapped", "Declare Result"),
                ),
                _ButtonData(
                  Icons.list_alt,
                  "Announced Result",
                  () => Get.snackbar("Tapped", "Announced Result"),
                ),
              ]),
              _section("Bazaar Operations", [
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
              _section("Reports & Analytics", [
                _ButtonData(
                  Icons.bar_chart,
                  "Customer Sell Report",
                  () => Get.snackbar("Tapped", "Customer Sell Report"),
                ),
                _ButtonData(
                  Icons.onetwothree,
                  "Left Digit",
                  () => Get.snackbar("Tapped", "Left Digit"),
                ),
                _ButtonData(
                  Icons.onetwothree,
                  "Right Digit",
                  () => Get.snackbar("Tapped", "Right Digit"),
                ),
                _ButtonData(
                  Icons.numbers,
                  "Jodi Digit",
                  () => Get.snackbar("Tapped", "Jodi Digit"),
                ),
              ]),
              _section("Winning Management", [
                _ButtonData(
                  Icons.emoji_events,
                  "Winning Report",
                  () => Get.snackbar("Tapped", "Winning Report"),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _statCards() {
  //   return SizedBox(
  //     height: 100,
  //     child: ListView(
  //       scrollDirection: Axis.horizontal,
  //       children: [
  //         _statCard("Today's Bets", "₹12,450", Colors.blue),
  //         _statCard("Active Users", "1,243", Colors.green),
  //         _statCard("Pending Results", "3", Colors.orange),
  //         _statCard("Total Profit", "₹8,720", Colors.purple),
  //       ],
  //     ),
  //   );
  // }

  Widget _statCard(String title, String value, Color color) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Admin,",
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              buttons
                  .map((btn) => _menuButton(btn.icon, btn.label, btn.onTap))
                  .toList(),
        ),
      ],
    );
  }

  Widget _menuButton(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Color(0xFF283593)),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
