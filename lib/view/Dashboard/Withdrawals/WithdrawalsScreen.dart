import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import '../../../controller/Home_Controllers/withdraw_controller.dart'
    show WithdrawalsController;

class WithdrawalsScreen extends StatelessWidget {
  WithdrawalsScreen({super.key});
  final WithdrawalsController controller = Get.put(WithdrawalsController());

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withdraw Request List',
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
            _buildSummaryCards(isSmallScreen),
            const SizedBox(height: 20),
            _buildSearchAndEntriesRow(isSmallScreen),
            const SizedBox(height: 20),
            _buildWithdrawRequestTable(isSmallScreen),
            const SizedBox(height: 20),
            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(bool isSmallScreen) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isSmallScreen ? 2 : 4,
      childAspectRatio: isSmallScreen ? 1.5 : 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildSummaryCard(
          title: 'Total Withdraw',
          value: '₹1355221',
          color: const Color(0xFF4E73DF),
        ),
        _buildSummaryCard(
          title: 'Approved',
          value: '₹1299332',
          color: const Color(0xFF1CC88A),
        ),
        _buildSummaryCard(
          title: 'Rejected',
          value: '₹81879',
          color: const Color(0xFFE74A3B),
        ),
        _buildSummaryCard(
          title: 'Pending',
          value: '₹14010',
          color: const Color(0xFFF6C23E),
        ),
      ],
    );
  }

  Widget _buildSearchAndEntriesRow(bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Entries Dropdown
          Obx(() => Container(
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
                    }
                  },
                  underline: const SizedBox(),
                  icon:
                      Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              )),
          const Spacer(),
          // Search Bar
          SizedBox(
            width: isSmallScreen ? 180 : 290,
            height: 48,
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: GoogleFonts.poppins(fontSize: 14),
                prefixIcon:
                    Icon(Icons.search, size: 20, color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
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

  Widget _buildWithdrawRequestTable(bool isSmallScreen) {
    return Obx(() {
      final displayedRequests = controller.filteredRequests
          .skip((controller.currentPage.value - 1) *
              controller.entriesPerPage.value)
          .take(controller.entriesPerPage.value)
          .toList();

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
              _buildDataColumn('#', 40),
              _buildDataColumn('DATE', 120),
              _buildDataColumn('USERNAME', 100),
              _buildDataColumn('MOBILE', 100),
              _buildDataColumn('AMOUNT', 80),
              _buildDataColumn('WALLET', 80),
              _buildDataColumn('STATUS', 100),
              _buildDataColumn('ACTIONS', 150),
            ],
            rows: displayedRequests.map((request) {
              return DataRow(
                cells: [
                  DataCell(Text(request['id'].toString())),
                  DataCell(Text(request['date'])),
                  DataCell(Text(request['username'])),
                  DataCell(Text(request['mobile'])),
                  DataCell(Text(request['amount'].isEmpty
                      ? ''
                      : '₹${request['amount']}')),
                  DataCell(Text(request['wallet'])),
                  DataCell(_buildStatusCell(request['status'])),
                  DataCell(_buildActionCell(request['status'])),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildPaginationControls() {
    return Obx(() {
      final totalPages =
          (controller.filteredRequests.length / controller.entriesPerPage.value)
              .ceil();

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
            ..._buildPageNumbers(totalPages),
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

  List<Widget> _buildPageNumbers(int totalPages) {
    final currentPage = controller.currentPage.value;
    final pages = <Widget>[];

    // Always show first page
    pages.add(_buildPageButton(1));

    // Show dots if current page is far from start
    if (currentPage > 4) {
      pages.add(const Text('...'));
    }

    // Show pages around current page
    for (int i = max(2, currentPage - 1);
        i <= min(totalPages - 1, currentPage + 1);
        i++) {
      if (i > 1 && i < totalPages) {
        pages.add(_buildPageButton(i));
      }
    }

    // Show dots if current page is far from end
    if (currentPage < totalPages - 3) {
      pages.add(const Text('...'));
    }

    // Always show last page if there's more than one page
    if (totalPages > 1) {
      pages.add(_buildPageButton(totalPages));
    }

    return pages;
  }

  int max(int a, int b) => a > b ? a : b;
  int min(int a, int b) => a < b ? a : b;

  Widget _buildStatusCell(String status) {
    if (status.isEmpty) return const SizedBox();

    Color bgColor;
    Color textColor;

    switch (status) {
      case 'PENDING':
        bgColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'APPROVED':
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      default:
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
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

  Widget _buildActionCell(String status) {
    if (status.isEmpty) return const SizedBox();
    if (status != 'PENDING') return const Text('NA');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => _handleAction('APPROVE'),
          child: Text(
            'Approve',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _handleAction('REJECT'),
          child: Text(
            'Reject',
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  void _handleAction(String action) {
    // Implement your action logic here
    Get.snackbar(
      action == 'APPROVE' ? 'Approved' : 'Rejected',
      'Withdrawal request has been ${action == 'APPROVE' ? 'approved' : 'rejected'}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: action == 'APPROVE' ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
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

  Widget _buildSummaryCard(
      {required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(int page) {
    return Obx(() => TextButton(
          onPressed: () => controller.currentPage.value = page,
          child: Text(
            page.toString(),
            style: GoogleFonts.poppins(
              color: page == controller.currentPage.value
                  ? const Color(0xFF1A237E)
                  : Colors.grey,
              fontWeight: page == controller.currentPage.value
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ));
  }
}
