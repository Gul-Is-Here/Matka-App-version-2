import 'package:flutter/material.dart';
import 'package:mtka_app_version2/constants/user.dart';

import 'dataColumnWidget.dart';

Widget buildSourceListTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search sources...',
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
                  buildDataColumn('#'),
                  buildDataColumn('VERSION NAME'),
                  buildDataColumn('TOTAL INSTALL'),
                  buildDataColumn('CURRENT INSTALL'),
                ],
                rows: sourceList.map((source) {
                  return DataRow(
                    cells: [
                      DataCell(Text(source['id'].toString())),
                      DataCell(Text(source['version'])),
                      DataCell(Text(source['totalInstall'])),
                      DataCell(Text(source['currentInstall'])),
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
