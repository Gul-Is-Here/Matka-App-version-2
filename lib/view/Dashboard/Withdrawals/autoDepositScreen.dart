import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/Home_Controllers/autoDeposit_controller.dart';

class AutoDepositScreen extends StatelessWidget {
  AutoDepositScreen({super.key});
  final FundRequestController controller = Get.put(FundRequestController());

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fund Request List',
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
            _buildEntriesDropdown(),
            const SizedBox(height: 16),
            _buildSearchAndFilterRow(isSmallScreen),
            const SizedBox(height: 16),
            _buildRequestTable(isSmallScreen),
            const SizedBox(height: 16),
            _buildPaginationControls(),
            const SizedBox(height: 16),
            _buildDeclareResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildEntriesDropdown() {
    return Obx(() => Row(
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
        ));
  }

  Widget _buildSearchAndFilterRow(bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                hintText: 'Search...',
                hintStyle: GoogleFonts.poppins(fontSize: 14),
                prefixIcon:
                    Icon(Icons.search, size: 20, color: Colors.grey.shade600),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                value: controller.selectedStatus.value,
                items: ['ALL', 'PENDING', 'APPROVED', 'REJECTED']
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
                    controller.selectedStatus.value = value;
                    controller.currentPage.value = 1;
                  }
                },
                underline: const SizedBox(),
                icon: Icon(Icons.filter_list, color: Colors.grey.shade600),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
            )),
      ],
    );
  }

  Widget _buildRequestTable(bool isSmallScreen) {
    return Obx(() {
      if (controller.filteredRequests.isEmpty) {
        return Center(
          child: Text(
            'No requests found',
            style: GoogleFonts.poppins(fontSize: 16),
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
              _buildDataColumn('#', 40),
              _buildDataColumn('USERNAME', 100),
              _buildDataColumn('POINTS', 80),
              _buildDataColumn('METHOD', 100),
              _buildDataColumn('DATE', 150),
              _buildDataColumn('STATUS', 100),
              _buildDataColumn('ACTIONS', 150),
            ],
            rows: controller.paginatedRequests.asMap().entries.map((entry) {
              final index = entry.key;
              final request = entry.value;
              return DataRow(
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Text(request['username'])),
                  DataCell(Text(request['points'].toString())),
                  DataCell(Text(request['method'])),
                  DataCell(Text(request['date'])),
                  DataCell(_buildStatusCell(request['status'])),
                  DataCell(_buildActionCells(request['status'], index)),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildStatusCell(String status) {
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
      case 'REJECTED':
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

  Widget _buildActionCells(String status, int index) {
    if (status == 'APPROVED' || status == 'REJECTED') {
      return const Text('Completed', style: TextStyle(color: Colors.grey));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => controller.approveRequest(index),
          child: Text(
            'Approve',
            style: GoogleFonts.poppins(
              color: Colors.green,
              fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () => controller.rejectRequest(index),
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

  Widget _buildPaginationControls() {
    return Obx(() {
      final totalPages =
          (controller.filteredRequests.length / controller.entriesPerPage.value)
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
    if (totalPages > 0) {
      pages.add(_buildPageButton(1));
    }

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
    if (currentPage < totalPages - 3 && totalPages > 1) {
      pages.add(const Text('...'));
    }

    // Always show last page if there's more than one page
    if (totalPages > 1) {
      pages.add(_buildPageButton(totalPages));
    }

    return pages;
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

  Widget _buildDeclareResultSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
            'Declare Result:',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Starline',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'GailDesavar',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  int max(int a, int b) => a > b ? a : b;
  int min(int a, int b) => a < b ? a : b;

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
