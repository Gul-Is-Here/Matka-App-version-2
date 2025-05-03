import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mtka_app_version2/controller/Menu/ReportManagement/trasnferPointController.dart'
    show TransferReportController;

class TransferPointReportScreen extends StatelessWidget {
  TransferPointReportScreen({super.key});
  final controller = Get.put(TransferReportController());
  final Color primaryColor =
      const Color(0xFF1A237E); // Using your specified color

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
          "Transfer Point Report",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transfer Point Report",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildFilterCard(),
            const SizedBox(height: 20),
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      elevation: 2,
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            _buildDatePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return SizedBox(
      width: 250,
      child: Obx(() => InkWell(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: Get.context!,
                initialDate: controller.selectedDate.value,
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
              if (picked != null) controller.selectedDate.value = picked;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey.shade600),
                  const SizedBox(width: 12),
                  Text(
                    DateFormat('MMM dd, yyyy')
                        .format(controller.selectedDate.value),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildDataTable() {
    return Expanded(
      child: Obx(() {
        if (controller.reportList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.swap_horiz, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  'No transfer records found',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        }

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => primaryColor.withOpacity(0.1),
              ),
              columnSpacing: 24,
              columns: [
                _buildDataColumn("#", 60),
                _buildDataColumn("DATE", 120),
                _buildDataColumn("SENDER NAME", 200),
                _buildDataColumn("RECEIVER NAME", 200),
                _buildDataColumn("AMOUNT", 120),
              ],
              rows: List.generate(controller.reportList.length, (index) {
                final row = controller.reportList[index];
                return DataRow(
                  cells: [
                    _buildDataCell("${index + 1}"),
                    _buildDataCell(row['date'] ?? ''),
                    _buildDataCell(row['sender'] ?? ''),
                    _buildDataCell(row['receiver'] ?? ''),
                    _buildDataCell(
                      row['amount'] ?? '',
                      isAmount: true,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }

  DataColumn _buildDataColumn(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text, {bool isAmount = false}) {
    return DataCell(
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: isAmount ? Colors.green.shade700 : Colors.grey.shade800,
        ),
      ),
    );
  }
}
