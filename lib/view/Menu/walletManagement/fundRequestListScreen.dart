import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/Menu/walletManagementController/addFundRequestListControler.dart'
    show FundRequestListController;

class FundRequestListScreen extends StatelessWidget {
  FundRequestListScreen({super.key});

  final controller = Get.put(FundRequestListController());
  final Color primaryColor = const Color(0xFF1A237E);
  final Color secondaryColor = const Color(0xFF303F9F);
  final Color backgroundColor = const Color(0xFFF5F5F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Fund Request List',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _buildDataTable(),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPagination(),
              ],
            )),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: controller.rowsPerPage.value,
                items: [10, 20, 50]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            "Show $e entries",
                            style: GoogleFonts.poppins(fontSize: 10),
                          ),
                        ))
                    .toList(),
                onChanged: (val) => controller.rowsPerPage.value = val!,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                elevation: 2,
                style: GoogleFonts.poppins(color: Colors.black87),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  onChanged: (val) => controller.searchText.value = val,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.poppins(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: Icon(Icons.search, color: primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => primaryColor.withOpacity(0.8)),
          headingTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          dataRowHeight: 60,
          columnSpacing: 24,
          horizontalMargin: 16,
          columns: const [
            DataColumn(label: Text("#", textAlign: TextAlign.center)),
            DataColumn(label: Text("USERNAME")),
            DataColumn(label: Text("POINTS", textAlign: TextAlign.center)),
            DataColumn(label: Text("METHOD")),
            DataColumn(label: Text("DATE")),
            DataColumn(label: Text("STATUS", textAlign: TextAlign.center)),
            DataColumn(label: Text("ACTIONS", textAlign: TextAlign.center)),
          ],
          rows: controller.paginatedData.map((row) {
            return DataRow(
              cells: [
                DataCell(Center(child: Text(row["id"].toString()))),
                DataCell(Text(row["username"],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                DataCell(Center(
                    child: Text(row["points"].toString(),
                        style: GoogleFonts.poppins()))),
                DataCell(Text(row["method"])),
                DataCell(Text(row["date"])),
                DataCell(Center(child: _statusChip(row["status"]))),
                DataCell(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _actionButton("Approve", Colors.green, () {
                      controller.approveRequest(row["id"]);
                    }),
                    const SizedBox(width: 8),
                    _actionButton("Reject", Colors.red, () {
                      controller.rejectRequest(row["id"]);
                    }),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color = Colors.orange;
    if (status == "APPROVED") color = Colors.green;
    if (status == "REJECTED") color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
          )),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: controller.previousPage,
            icon: Icon(Icons.chevron_left, color: primaryColor),
            splashRadius: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => Text(
                  "Page ${controller.currentPage.value}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                )),
          ),
          IconButton(
            onPressed: controller.nextPage,
            icon: Icon(Icons.chevron_right, color: primaryColor),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
