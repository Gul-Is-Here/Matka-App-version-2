import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Menu/ReportManagement/widthdrawReportController.dart'
    show WithdrawReportController;

class WithdrawReportScreen extends StatelessWidget {
  WithdrawReportScreen({super.key});
  final controller = Get.put(WithdrawReportController());

  final List<String> byOptions = ['All', 'Admin', 'User'];
  final List<String> statusOptions = ['All', 'Success', 'Pending', 'Failed'];
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: primaryColor,
        title: Text(
          'Withdraw Report',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(),
            const SizedBox(height: 16),
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              _buildDateField("Date", controller.selectedDate),
              _buildTextField("Username", controller.username),
              _buildTextField("Phone", controller.phone),
              _buildDropdown("Withdrawn By", controller.withdrawnBy, byOptions),
              _buildDropdown("Transaction Status", controller.transactionStatus,
                  statusOptions),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.filterData,
                  icon: const Icon(Icons.search, size: 20),
                  label: Text('Search', style: GoogleFonts.poppins()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.resetFilters,
                  icon: const Icon(Icons.refresh),
                  label: Text('Reset', style: GoogleFonts.poppins()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, Rx<DateTime> value) {
    return SizedBox(
      width: 200,
      child: Obx(() => InkWell(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: Get.context!,
                initialDate: value.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) value.value = picked;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat('MMM dd, yyyy').format(value.value),
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildTextField(String label, RxString value) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextFormField(
              onChanged: (val) => value.value = val,
              style: GoogleFonts.poppins(fontSize: 10),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, RxString selected, List<String> options) {
    return SizedBox(
      width: 200,
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: selected.value,
                  onChanged: (val) => selected.value = val ?? '',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: options
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(fontSize: 10),
                          )))
                      .toList(),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildDataTable() {
    return Obx(() {
      if (controller.rows.isEmpty) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'No withdrawal records found',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        );
      }

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
              _buildColumn("#"),
              _buildColumn("Username"),
              _buildColumn("User Phone"),
              _buildColumn("Amount"),
              _buildColumn("By"),
              _buildColumn("Status"),
              _buildColumn("Date"),
            ],
            rows: List.generate(controller.rows.length, (index) {
              final row = controller.rows[index];
              return DataRow(
                cells: [
                  _buildCell("${index + 1}"),
                  _buildCell(row['username'] ?? ''),
                  _buildCell(row['phone'] ?? ''),
                  _buildCell(row['amount'] ?? '', isAmount: true),
                  _buildCell(row['by'] ?? ''),
                  _buildCell(row['status'] ?? ''),
                  _buildCell(row['date'] ?? ''),
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  DataColumn _buildColumn(String label) {
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

  DataCell _buildCell(String text, {bool isAmount = false}) {
    return DataCell(
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 8,
          fontWeight: isAmount ? FontWeight.w500 : FontWeight.normal,
          color: isAmount ? Colors.green.shade700 : Colors.grey.shade800,
        ),
      ),
    );
  }
}
