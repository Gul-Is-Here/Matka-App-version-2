import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtka_app_version2/view/Dashboard/Totalusers/users.dart';
import 'package:mtka_app_version2/widgets/DashBoard/stateCardWidget.dart';

import '../../view/Dashboard/Withdrawals/totalDepositScreenByAdmin.dart';

Widget buildMainStatsSection(BuildContext context, bool isSmallScreen) {
  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TotalUsersScreen()),
            );
          },
          child: buildStatCard(
            context,
            title: "Total Users",
            value: "929",
            icon: Icons.people_alt_rounded,
            color: const Color(0xFF4E73DF),
            progress: 0.534,
            subtitle: "53.4% Active",
            isSmallScreen: isSmallScreen,
          ),
        ),
      ),
      SizedBox(width: isSmallScreen ? 12 : 16),
      Expanded(
        child: buildStatCard(
          context,
          title: "Active Users",
          value: "492",
          icon: Icons.account_balance_wallet,
          color: const Color(0xFF1CC88A),
          progress: 0.72,
          subtitle: "",
          isSmallScreen: isSmallScreen,
        ),
      ),
    ],
  );
}
