import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtka_app_version2/widgets/DashBoard/buildBottomStateWidget.dart';
import '../Menu/sidemenu.dart';
import '../../widgets/DashBoard/gridSectionWidget.dart' show buildGridCard;
import '../../widgets/DashBoard/headerSectionWidget.dart';
import '../../widgets/DashBoard/stateSectionWidget.dart';
import 'Withdrawals/WithdrawalsScreen.dart';
import 'Withdrawals/autoDepositScreen.dart';
import 'Withdrawals/totalDepositScreen.dart';
import 'Withdrawals/totalDepositScreenByAdmin.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      drawer: const SideMenu(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // This makes drawer icon white
        title: Text(
          "Admin Dashboard",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: isSmallScreen ? 18 : 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A237E),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A237E),
                Color(0xFF283593),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
          child: Column(
            children: [
              buildHeaderSection(context, isSmallScreen),
              const SizedBox(height: 16),
              buildMainStatsSection(context, isSmallScreen),
              const SizedBox(height: 20),
              _buildStatsGridSection(context, isSmallScreen),
              const SizedBox(height: 20),
              buildBottomStatsSection(context, isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGridSection(BuildContext context, bool isSmallScreen) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isSmallScreen ? 2 : 4,
      childAspectRatio: isSmallScreen ? 1.1 : 1.3,
      crossAxisSpacing: isSmallScreen ? 12 : 16,
      mainAxisSpacing: isSmallScreen ? 12 : 16,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WithdrawalsScreen()),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: buildGridCard(
            title: "Withdrawals",
            value: "0 - 0 - 0",
            description: "15 Pending",
            icon: Icons.money_off,
            color: const Color(0xFFE74A3B),
            isSmallScreen: isSmallScreen,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => AutoDepositScreen());
          },
          child: buildGridCard(
            title: "Auto Deposit",
            value: "49.2",
            description: "Total Amount",
            icon: Icons.auto_graph,
            color: const Color(0xFF36B9CC),
            isSmallScreen: isSmallScreen,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => AutoDepositByAdminScreen());
          },
          child: buildGridCard(
            title: "Total Deposit",
            value: "0 - 0 - 0",
            description: "Admin/User/Bonus",
            icon: Icons.pie_chart,
            color: const Color(0xFFF6C23E),
            isSmallScreen: isSmallScreen,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => TotalDepositScreen());
          },
          child: buildGridCard(
            title: "Total Deposit",
            value: "0",
            description: "",
            icon: Icons.pie_chart,
            color: const Color.fromARGB(255, 87, 187, 93),
            isSmallScreen: isSmallScreen,
          ),
        ),
        buildGridCard(
          title: "Total Win",
          value: "0",
          description: "",
          icon: Icons.people_outline,
          color: const Color(0xFF5A5C69),
          isSmallScreen: isSmallScreen,
        ),
        buildGridCard(
          title: "Total Players",
          value: "0",
          description: "Active Today",
          icon: Icons.people_outline,
          color: const Color(0xFF5A5C69),
          isSmallScreen: isSmallScreen,
        ),
      ],
    );
  }
}
