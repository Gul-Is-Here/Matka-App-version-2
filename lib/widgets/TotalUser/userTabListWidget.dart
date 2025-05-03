import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtka_app_version2/constants/user.dart';
import 'package:mtka_app_version2/widgets/TotalUser/dataColumnWidget.dart';

Widget buildUserListTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_list, color: const Color(0xFF1A237E)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: DataTable(
                columnSpacing: 24,
                columns: [
                  buildDataColumn('Show'),
                  buildDataColumn('ID'),
                  buildDataColumn('NAME'),
                  buildDataColumn('MOBILE NUMBER'),
                  buildDataColumn('DATE/LAST SEEN'),
                  buildDataColumn('BALANCE'),
                  buildDataColumn('TRANSFER'),
                  buildDataColumn('ACTIVE'),
                  buildDataColumn('STATUS'),
                ],
                rows: userList.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Checkbox(value: false, onChanged: (v) {})),
                      DataCell(Text(user['id'].toString())),
                      DataCell(
                        Text(
                          user['name'],
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                      ),
                      DataCell(Text(user['mobile'])),
                      DataCell(Text(user['lastSeen'])),
                      DataCell(
                        Text(
                          user['balance'],
                          style: GoogleFonts.poppins(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataCell(Text(user['transfer'])),
                      DataCell(Text(user['active'])),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: user['status'] == 'Active'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            user['status'],
                            style: GoogleFonts.poppins(
                              color: user['status'] == 'Active'
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
