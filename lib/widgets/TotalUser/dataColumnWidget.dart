import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

DataColumn buildDataColumn(String label) {
  return DataColumn(
    label: Text(
      label,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A237E),
      ),
    ),
  );
}