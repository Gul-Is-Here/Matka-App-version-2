import 'package:flutter/material.dart';
import 'package:mtka_app_version2/widgets/DashBoard/heighightCardSection.dart';
import 'package:mtka_app_version2/widgets/DashBoard/profilelossCardWidget.dart';

Widget buildBottomStatsSection(BuildContext context, bool isSmallScreen) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: buildHighlightCard(
                title: "Win Amount",
                value: "₹0",
                icon: Icons.celebration,
                color: const Color(0xFF1CC88A),
                isSmallScreen: isSmallScreen,
              ),
            ),
            SizedBox(width: isSmallScreen ? 12 : 16),
            Expanded(
              child: buildHighlightCard(
                title: "Bid Amount",
                value: "₹0",
                icon: Icons.help_outline,
                color: const Color(0xFF36B9CC),
                isSmallScreen: isSmallScreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        buildProfitLossCard(context, isSmallScreen),
      ],
    );
  }