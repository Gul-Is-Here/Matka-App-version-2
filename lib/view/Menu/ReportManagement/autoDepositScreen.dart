import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mtka_app_version2/controller/Menu/ReportManagement/autoDepositController.dart';

class AutoDepositScreen extends StatelessWidget {
  AutoDepositScreen({super.key});
  final controller = Get.put(AutoDepositController());

  final List<String> statusOptions = ['All', 'Success', 'Pending', 'Failed'];
  final Color primaryColor = const Color(0xFF1A237E); // Deep blue
  final Color accentColor = const Color(0xFF303F9F); // Light blue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(
              'Auto Deposit Report',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            pinned: true,
            floating: true,
            elevation: 4,
            expandedHeight: 60,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, accentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterCard(),
                  const SizedBox(height: 16),
                  _buildDataTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: primaryColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_alt_rounded, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  'FILTER OPTIONS',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDateFilter(),
                _buildTextFieldFilter('Username', controller.username),
                _buildTextFieldFilter('Phone', controller.phone),
                _buildStatusFilter(),
              ],
            ),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: Get.context!,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
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
                  if (picked != null) {
                    controller.selectedDate.value = picked;
                  }
                },
                child: Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 20, color: primaryColor),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat('MMM dd, yyyy')
                            .format(controller.selectedDate.value),
                        style: GoogleFonts.poppins(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTextFieldFilter(String label, RxString controller) {
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
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextFormField(
              onChanged: (val) => controller.value = val,
              style: GoogleFonts.poppins(fontSize: 10),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                filled: true,
                fillColor: Colors.white,
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey.shade400, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() => SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: controller.status.value,
                  onChanged: (val) => controller.status.value = val ?? 'All',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
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
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  icon:
                      Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                  items: statusOptions
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

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.filterData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Apply Filters',
              style: GoogleFonts.poppins(
                fontSize: 12,
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
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Reset',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: primaryColor),
              const SizedBox(height: 16),
              Text(
                'Loading data...',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.rows.isEmpty) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet,
                      size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No deposit records found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: controller.refreshData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Refresh',
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(Get.context!).size.width - 32,
            ),
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => primaryColor.withOpacity(0.1),
              ),
              columnSpacing: 24,
              dataRowHeight: 56,
              headingRowHeight: 56,
              columns: [
                _buildDataColumn("#", 60),
                _buildDataColumn("USERNAME", 140),
                _buildDataColumn("PHONE", 140),
                _buildDataColumn("AMOUNT", 120),
                _buildDataColumn("STATUS", 120),
                _buildDataColumn("DATE", 120),
              ],
              rows: List.generate(controller.rows.length, (index) {
                final row = controller.rows[index];
                return DataRow(
                  cells: [
                    _buildDataCell("${index + 1}"),
                    _buildDataCell(row['username'] ?? ''),
                    _buildDataCell(row['phone'] ?? ''),
                    _buildDataCell(
                      '\$${row['amount'] ?? '0.00'}',
                      isAmount: true,
                    ),
                    _buildStatusCell(row['status'] ?? ''),
                    _buildDataCell(row['date'] ?? ''),
                  ],
                );
              }),
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
            color: primaryColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getStatusColor(status),
          borderRadius: BorderRadius.circular(16),
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
}
