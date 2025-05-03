import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Home_Controllers/totalDepositController.dart' show TotalDepositController;
import '../../../controller/Home_Controllers/totalDepositControllerByAdmin.dart'
    show TotalDepositByAdminController;

class TotalDepositScreen extends StatelessWidget {
  TotalDepositScreen({super.key});
  final TotalDepositController controller =
      Get.put(TotalDepositController());

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Admin',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(),
            const SizedBox(height: 20),
            _buildFilterControls(isSmallScreen),
            const SizedBox(height: 20),
            _buildEntriesDropdown(),
            const SizedBox(height: 20),
            _buildTransactionsTable(isSmallScreen),
            const SizedBox(height: 20),
            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    return Row(
      children: [
        Text(
          'Date: ${controller.currentDate}',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterControls(bool isSmallScreen) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTransactionTypeDropdown(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTransactionStatusDropdown(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSearchField(isSmallScreen),
      ],
    );
  }

  Widget _buildTransactionTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: controller.selectedTransactionType.value,
        isExpanded: true,
        items: ['All', 'Deposit', 'Withdrawal', 'Transfer', 'Bonus']
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedTransactionType.value = value;
            controller.currentPage.value = 1;
          }
        },
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
        style: GoogleFonts.poppins(color: Colors.black),
      ),
    );
  }

  Widget _buildTransactionStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: controller.selectedTransactionStatus.value,
        isExpanded: true,
        items: ['All', 'Pending', 'Completed', 'Failed', 'Cancelled']
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectedTransactionStatus.value = value;
            controller.currentPage.value = 1;
          }
        },
        underline: const SizedBox(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
        style: GoogleFonts.poppins(color: Colors.black),
      ),
    );
  }

  Widget _buildSearchField(bool isSmallScreen) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        onChanged: (value) {
          controller.searchQuery.value = value;
          controller.currentPage.value = 1;
        },
        decoration: InputDecoration(
          hintText: 'Search by username or phone...',
          hintStyle: GoogleFonts.poppins(fontSize: 14),
          prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade600),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildEntriesDropdown() {
    return Row(
      children: [
        Text(
          'Show',
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<int>(
            value: controller.entriesPerPage.value,
            items: [10, 25, 50, 100]
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        '$value entries',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.entriesPerPage.value = value;
                controller.currentPage.value = 1;
              }
            },
            underline: const SizedBox(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsTable(bool isSmallScreen) {
    if (controller.filteredTransactions.isEmpty) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No data available in table',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(Get.context!).size.width - 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: DataTable(
          columnSpacing: 16,
          headingRowHeight: 50,
          dataRowHeight: 50,
          columns: [
            _buildDataColumn('USERNAME', 120),
            _buildDataColumn('PHONE NUMBER', 120),
            _buildDataColumn('AMOUNT', 100),
            _buildDataColumn('STATUS', 100),
            _buildDataColumn('DETAILS', 150),
            _buildDataColumn('DATE', 120),
          ],
          rows: controller.paginatedTransactions.map((transaction) {
            return DataRow(
              cells: [
                DataCell(Text(transaction['username'] ?? '')),
                DataCell(Text(transaction['phone'] ?? '')),
                DataCell(Text('₹${transaction['amount']?.toString() ?? ''}')),
                DataCell(_buildStatusCell(transaction['status'] ?? '')),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.info_outline, size: 20),
                    onPressed: () => _showTransactionDetails(transaction),
                  ),
                ),
                DataCell(Text(
                  transaction['date'] != null
                      ? DateFormat('MM/dd/yyyy').format(transaction['date'])
                      : '',
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusCell(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'completed':
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'failed':
      case 'cancelled':
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Transaction Details',
          style: GoogleFonts.poppins(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Username:', transaction['username'] ?? ''),
            _buildDetailRow('Phone:', transaction['phone'] ?? ''),
            _buildDetailRow(
                'Amount:', '₹${transaction['amount']?.toString() ?? ''}'),
            _buildDetailRow('Type:', transaction['type'] ?? ''),
            _buildDetailRow('Status:', transaction['status'] ?? ''),
            _buildDetailRow(
                'Date:',
                transaction['date'] != null
                    ? DateFormat('MM/dd/yyyy HH:mm').format(transaction['date'])
                    : ''),
            const SizedBox(height: 16),
            Text(
              'Additional Details:',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              transaction['details'] ?? 'No additional details',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: GoogleFonts.poppins())),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Obx(() {
      final totalPages = (controller.filteredTransactions.length /
              controller.entriesPerPage.value)
          .ceil();
      if (totalPages <= 1) return const SizedBox();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: controller.currentPage.value > 1
                  ? () => controller.currentPage.value--
                  : null,
              child: Text('Previous', style: GoogleFonts.poppins()),
            ),
            const SizedBox(width: 8),
            Text(
              'Page ${controller.currentPage.value} of $totalPages',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: controller.currentPage.value < totalPages
                  ? () => controller.currentPage.value++
                  : null,
              child: Text('Next', style: GoogleFonts.poppins()),
            ),
          ],
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
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A237E),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
