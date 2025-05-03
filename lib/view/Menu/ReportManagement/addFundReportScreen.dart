import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mtka_app_version2/controller/Menu/ReportManagement/addFundReportController.dart';

class AddFundReportScreen extends StatelessWidget {
  final controller = Get.put(AddFundReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Fund Report',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A237E),
                Color(0xFF303F9F),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: controller.refreshData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildModernFilterSection(),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildReportTable(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFilterSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_rounded,
                  color: Color(0xFF1A237E),
                ),
                const SizedBox(width: 8),
                Text(
                  'FILTER OPTIONS',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildModernDateFilter(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildModernTextFieldFilter(
                    'Username',
                    controller.username,
                    icon: Icons.person_outline,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildModernTextFieldFilter(
                    'Phone',
                    controller.phone,
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildModernDropdownFilter(
                    'Transaction Type',
                    controller.transactionType,
                    controller.typeOptions,
                    icon: Icons.swap_horiz_outlined,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildModernDropdownFilter(
                    'Transaction Status',
                    controller.transactionStatus,
                    controller.statusOptions,
                    icon: Icons.info_outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildModernActionButtons(),
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
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final dateFormat = DateFormat('MMM dd, yyyy');
          return InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: Get.context!,
                initialDate: controller.selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFF1A237E),
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
              if (picked != null) {
                controller.selectedDate.value = picked;
                controller.filterData();
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                    color: Color(0xFF1A237E),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    dateFormat.format(controller.selectedDate.value),
                    style: GoogleFonts.poppins(fontSize: 10),
                  ),
                  const Spacer(),
                  if (dateFormat.format(controller.selectedDate.value) !=
                      dateFormat.format(DateTime.now()))
                    InkWell(
                      onTap: () {
                        controller.selectedDate.value = DateTime.now();
                        controller.filterData();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildModernTextFieldFilter(
    String label,
    RxString value, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
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
            onChanged: (val) {
              value.value = val;
              controller.debounceFilter();
            },
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(fontSize: 10),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              prefixIcon: icon != null ? Icon(icon, size: 20) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF1A237E),
                  width: 1.5,
                ),
              ),
              suffixIcon: value.isNotEmpty
                  ? IconButton(
                      icon:
                          const Icon(Icons.close, size: 18, color: Colors.grey),
                      onPressed: () {
                        value.value = '';
                        controller.filterData();
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdownFilter(
      String label, RxString selected, List<String> options,
      {IconData? icon}) {
    return Column(
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
        Obx(() => SizedBox(
              height: 40,
              child: DropdownButtonFormField<String>(
                value: selected.value,
                onChanged: (val) {
                  selected.value = val ?? '';
                  controller.filterData();
                },
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.grey.shade800,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 14,
                  ),
                  prefixIcon: icon != null ? Icon(icon, size: 15) : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF1A237E),
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                items: options
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
              ),
            )),
      ],
    );
  }

  Widget _buildModernActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.filterData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1A237E),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Apply Filters',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: controller.resetFilters,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1A237E),
              side: const BorderSide(color: Color(0xFF1A237E)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Reset',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportTable() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF1A237E)),
              ),
              const SizedBox(height: 16),
              Text(
                'Loading transactions...',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.rows.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                'No transactions found',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              if (controller.hasError.value)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: GoogleFonts.poppins(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: controller.refreshData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Retry'),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => const Color(0xFF1A237E).withOpacity(0.05),
              ),
              columns: [
                _buildDataColumn('#', 60),
                _buildDataColumn('USERNAME', 120),
                _buildDataColumn('PHONE', 120),
                _buildDataColumn('AMOUNT', 100),
                _buildDataColumn('STATUS', 120),
                _buildDataColumn('TYPE', 100),
                _buildDataColumn('DATE', 120),
                _buildDataColumn('ACTIONS', 80),
              ],
              rows: controller.rows.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                return DataRow(
                  cells: [
                    _buildDataCell('${index + 1}'),
                    _buildDataCell(row['username'] ?? 'N/A'),
                    _buildDataCell(row['phone'] ?? 'N/A'),
                    _buildDataCell(
                      '\$${row['amount']?.toStringAsFixed(2) ?? '0.00'}',
                      isAmount: true,
                    ),
                    _buildStatusCell(row['status'] ?? ''),
                    _buildDataCell(row['type'] ?? 'N/A'),
                    _buildDataCell(row['date'] ?? 'N/A'),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined,
                            size: 20, color: Color(0xFF1A237E)),
                        onPressed: () => _showDetailsDialog(row),
                        tooltip: 'View details',
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }

  DataColumn _buildDataColumn(String label, double width) {
    return DataColumn(
      label: SizedBox(
        width: width,
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A237E),
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  DataCell _buildDataCell(String text, {bool isAmount = false}) {
    return DataCell(
      Container(
        alignment: isAmount ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isAmount ? Colors.green.shade700 : Colors.grey.shade800,
            fontWeight: isAmount ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  DataCell _buildStatusCell(String status) {
    return DataCell(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getStatusColor(status),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade600;
      case 'failed':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  void _showDetailsDialog(Map<String, dynamic> data) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction Details',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Username', data['username']),
              _buildDetailRow('Phone', data['phone']),
              _buildDetailRow(
                'Amount',
                '\$${data['amount']?.toStringAsFixed(2) ?? '0.00'}',
                isAmount: true,
              ),
              _buildDetailRow('Status', data['status']),
              _buildDetailRow('Type', data['type']),
              _buildDetailRow('Date', data['date']),
              _buildDetailRow('Reference', data['reference'] ?? 'N/A'),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1A237E),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: GoogleFonts.poppins(
                color: isAmount ? Colors.green.shade700 : Colors.grey.shade800,
                fontWeight: isAmount ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
