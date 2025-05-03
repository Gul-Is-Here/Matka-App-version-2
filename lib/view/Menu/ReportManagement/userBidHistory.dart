import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Menu/ReportManagement/userBidHistoryController.dart';

class BidHistoryScreen extends StatelessWidget {
  BidHistoryScreen({super.key});
  final controller = Get.put(BidHistoryController());
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        title: Text(
          'Bid History',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildModernFilterSection(isMobile: isMobile),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bid History List",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Total Bid Amount: ₹429",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            controller.paginatedRows.isEmpty
                ? const Center(child: Text("No records found"))
                : _buildDataTable(),
            const SizedBox(height: 16),
            Obx(() =>
                controller.totalPages > 1 ? _buildPagination() : SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildModernFilterSection({required bool isMobile}) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildModernDateFilter(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildModernTextFieldFilter('Username', controller.username),
                _buildModernTextFieldFilter('Phone', controller.phone),
                _buildModernDropdownFilter('Game Name', controller.gameName,
                    ["All", "KALYAN", "TIME BAZAR"]),
                _buildModernDropdownFilter('Game Type', controller.gameType,
                    ["All", "Single Digit", "Jodi Digit", "Single Panna"]),
                _buildModernDropdownFilter('Game Session',
                    controller.gameSession, ["Both", "Open", "Close"]),
                _buildModernDropdownFilter('Single Digit',
                    controller.singleDigit, ["All", "1", "2", "3"]),
                _buildModernDropdownFilter('Jodi Digit', controller.jodiDigit,
                    ["All", "11", "22", "33"]),
                _buildModernDropdownFilter(
                    'Panna', controller.panna, ["All", "678", "666"]),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.filterData,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Apply Filters',
                        style: GoogleFonts.poppins(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.resetFilters,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        Text('Reset', style: GoogleFonts.poppins(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: Get.context!,
              initialDate: controller.selectedDate.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (picked != null) controller.selectedDate.value = picked;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  DateFormat('MMM dd, yyyy')
                      .format(controller.selectedDate.value),
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextFieldFilter(String label, RxString value) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextFormField(
              onChanged: (val) => value.value = val,
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDropdownFilter(
      String label, RxString selected, List<String> options) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: selected.value.isEmpty ? options[0] : selected.value,
                  onChanged: (val) => selected.value = val ?? '',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: options
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style: GoogleFonts.poppins(fontSize: 10)),
                          ))
                      .toList(),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: DataTable(
            columnSpacing: 10,
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => primaryColor.withOpacity(0.1),
            ),
            columns: [
              _buildDataColumn("#"),
              _buildDataColumn("Date"),
              _buildDataColumn("User Name"),
              _buildDataColumn("Game Name"),
              _buildDataColumn("Game Type"),
              _buildDataColumn("Session"),
              _buildDataColumn("Open Panna"),
              _buildDataColumn("Open Digit"),
              _buildDataColumn("Close Panna"),
              _buildDataColumn("Close Digit"),
              _buildDataColumn("Points"),
              _buildDataColumn("Action"),
            ],
            rows: List.generate(controller.paginatedRows.length, (index) {
              final row = controller.paginatedRows[index];
              return DataRow(
                cells: [
                  _buildDataCell("${index + 1}"),
                  _buildDataCell(row['date']),
                  _buildDataCell(row['user']),
                  _buildDataCell(row['gameName']),
                  _buildDataCell(row['gameType']),
                  _buildDataCell(row['session']),
                  _buildDataCell(row['openPanna']),
                  _buildDataCell(row['openDigit']),
                  _buildDataCell(row['closePanna']),
                  _buildDataCell(row['closeDigit']),
                  _buildDataCell(row['points']),
                  DataCell(
                    IconButton(
                      icon:
                          const Icon(Icons.edit, size: 10, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text) {
    return DataCell(
      Text(
        text,
        style: GoogleFonts.poppins(fontSize: 8),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: controller.currentPage.value > 1
              ? () => controller.currentPage.value--
              : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
          ),
          child: const Text("Previous"),
        ),
        const SizedBox(width: 16),
        Text(
          "Page ${controller.currentPage.value}",
          style: GoogleFonts.poppins(),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () => controller.currentPage.value++,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
          ),
          child: const Text("Next"),
        ),
      ],
    );
  }
}
