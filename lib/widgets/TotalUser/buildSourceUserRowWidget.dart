import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

DataRow buildUserRow(Map<String, dynamic> user) {
  return DataRow(
    cells: [
      DataCell(Checkbox(value: false, onChanged: (v) {})),
      DataCell(Text(user['id'].toString())),
      DataCell(Text(user['name'],
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
      DataCell(Text(user['mobile'])),
      DataCell(Text(user['lastSeen'])),
      DataCell(Text(user['balance'],
          style: GoogleFonts.poppins(
              color: Colors.green, fontWeight: FontWeight.w600))),
      DataCell(Text(user['transfer'])),
      DataCell(Text(user['active'])),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: user['status'] == 'Active'
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            user['status'],
            style: GoogleFonts.poppins(
              color: user['status'] == 'Active' ? Colors.green : Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}
