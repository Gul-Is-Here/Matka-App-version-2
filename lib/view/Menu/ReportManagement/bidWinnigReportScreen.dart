import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Menu/ReportManagement/bidWinningReportController.dart'
    show BidWinningReportController;

class BidWinningReportScreen extends StatelessWidget {
  BidWinningReportScreen({super.key});
  final controller = Get.put(BidWinningReportController());
  final Color primaryColor =
      const Color(0xFF1A237E); // Using your specified color

  final List<String> games = [
    "Select Category",
    "KALYAN",
    "TIME BAZAR",
    "SRIDEVI MORNING"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Bid Winning Report",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterCard(),
            const SizedBox(height: 20),
            _buildSummaryCards(),
            const SizedBox(height: 20),
            _buildDataTablesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FILTERS',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDateField("Date", controller.selectedDate),
                _buildDropdown("Game Name", controller.gameName, games),
                _buildTextField("Username", controller.username),
                _buildTextField("Phone", controller.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, Rx<DateTime> value) {
    return SizedBox(
      width: 200,
      height: 40,
      child: Obx(() => TextFormField(
            readOnly: true,
            style: GoogleFonts.poppins(fontSize: 10),
            controller: TextEditingController(
              text: DateFormat('MMM dd, yyyy').format(value.value),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: Get.context!,
                initialDate: value.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: primaryColor,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) value.value = picked;
            },
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryColor),
              ),
              suffixIcon: const Icon(Icons.calendar_today, size: 16),
            ),
          )),
    );
  }

  Widget _buildDropdown(String label, RxString selected, List<String> options) {
    return SizedBox(
      width: 200,
      height: 50,
      child: Obx(() => DropdownButtonFormField<String>(
            value: selected.value.isEmpty ? options[0] : selected.value,
            onChanged: (val) => selected.value = val ?? '',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 10),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.poppins(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
            dropdownColor: Colors.white,
            items: options
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: GoogleFonts.poppins()),
                    ))
                .toList(),
          )),
    );
  }

  Widget _buildTextField(String label, RxString controllerValue) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextFormField(
        onChanged: (val) => controllerValue.value = val,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(fontSize: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Obx(() => Row(
          children: [
            Expanded(
                child: _buildSummaryCard(
              "BIDS AMOUNT",
              controller.totalBid.value,
              primaryColor,
            )),
            const SizedBox(width: 12),
            Expanded(
                child: _buildSummaryCard(
              "WIN AMOUNT",
              controller.totalWin.value,
              Colors.green.shade100,
            )),
            const SizedBox(width: 12),
            Expanded(
                child: _buildSummaryCard(
              "PROFIT AMOUNT",
              controller.totalProfit.value,
              Colors.blue.shade100,
            )),
          ],
        ));
  }

  Widget _buildSummaryCard(String title, String value, Color bgColor) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTablesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bid & Winning Reports",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildTableCard(
          title: "Bids List",
          child: _horizontalTable(child: Obx(() => _buildBidsTable())),
        ),
        const SizedBox(height: 20),
        _buildTableCard(
          title: "Winning List",
          child: _horizontalTable(child: Obx(() => _buildWinsTable())),
        ),
      ],
    );
  }

  Widget _buildTableCard({required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Showing ${title.contains("Bids") ? controller.bids.length : controller.wins.length} entries",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            child,
          ],
        ),
      ),
    );
  }

  Widget _horizontalTable({required Widget child}) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(Get.context!).size.width - 32,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBidsTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
        (states) => primaryColor.withOpacity(0.1),
      ),
      columnSpacing: 24,
      columns: [
        _buildDataColumn("#"),
        _buildDataColumn("DATE"),
        _buildDataColumn("USER NAME"),
        _buildDataColumn("GAME NAME"),
        _buildDataColumn("GAME TYPE"),
        _buildDataColumn("SESSION"),
        _buildDataColumn("OPEN PANNA"),
        _buildDataColumn("OPEN DIGIT"),
        _buildDataColumn("CLOSE PANNA"),
        _buildDataColumn("CLOSE DIGIT"),
        _buildDataColumn("POINTS"),
      ],
      rows: List.generate(controller.bids.length, (index) {
        final row = controller.bids[index];
        return DataRow(
          cells: [
            _buildDataCell("${index + 1}"),
            _buildDataCell(row['date'] ?? ''),
            _buildDataCell(row['username'] ?? ''),
            _buildDataCell(row['gameName'] ?? ''),
            _buildDataCell(row['gameType'] ?? ''),
            _buildDataCell(row['session'] ?? ''),
            _buildDataCell(row['openPanna'] ?? ''),
            _buildDataCell(row['openDigit'] ?? ''),
            _buildDataCell(row['closePanna'] ?? ''),
            _buildDataCell(row['closeDigit'] ?? ''),
            _buildDataCell(row['points'] ?? ''),
          ],
        );
      }),
    );
  }

  Widget _buildWinsTable() {
    if (controller.wins.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                "No winning data available",
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
        (states) => primaryColor.withOpacity(0.1),
      ),
      columnSpacing: 24,
      columns: [
        _buildDataColumn("#"),
        _buildDataColumn("DATE"),
        _buildDataColumn("USER MOBILE"),
        _buildDataColumn("USER NAME"),
        _buildDataColumn("GAME NAME"),
        _buildDataColumn("GAME TYPE"),
        _buildDataColumn("OPEN PANNA"),
        _buildDataColumn("OPEN DIGIT"),
        _buildDataColumn("CLOSE PANNA"),
        _buildDataColumn("CLOSE DIGIT"),
        _buildDataColumn("WINNING AMOUNT"),
        _buildDataColumn("POINTS"),
      ],
      rows: List.generate(controller.wins.length, (index) {
        final row = controller.wins[index];
        return DataRow(
          cells: [
            _buildDataCell("${index + 1}"),
            _buildDataCell(row['date'] ?? ''),
            _buildDataCell(row['mobile'] ?? ''),
            _buildDataCell(row['username'] ?? ''),
            _buildDataCell(row['gameName'] ?? ''),
            _buildDataCell(row['gameType'] ?? ''),
            _buildDataCell(row['openPanna'] ?? ''),
            _buildDataCell(row['openDigit'] ?? ''),
            _buildDataCell(row['closePanna'] ?? ''),
            _buildDataCell(row['closeDigit'] ?? ''),
            _buildDataCell(row['winAmount'] ?? '', isAmount: true),
            _buildDataCell(row['points'] ?? ''),
          ],
        );
      }),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: primaryColor,
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text, {bool isAmount = false}) {
    return DataCell(
      Container(
        constraints: const BoxConstraints(minWidth: 80),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isAmount ? Colors.green.shade700 : Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
}
