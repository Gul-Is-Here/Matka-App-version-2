import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildGridCard({
  required String title,
  required String value,
  required String description,
  required IconData icon,
  required Color color,
  required bool isSmallScreen,
}) {
  return Container(
    padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 6,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: isSmallScreen ? 16 : 20, color: color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          maxLines: 1,
          value,
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 16 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: isSmallScreen ? 10 : 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
}
