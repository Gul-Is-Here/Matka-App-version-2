import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/Menu/ReportManagement/winningReportController.dart'
    show WinningReportController;

class WinningReportScreen extends StatelessWidget {
  WinningReportScreen({super.key});
  final controller = Get.put(WinningReportController());

  final List<String> gameList = [
    'All',
    'KALYAN',
    'TIME BAZAR',
    'SRIDEVI MORNING'
  ];
  final List<String> sessionList = ['Both', 'Open', 'Close'];
  final List<String> typeList = ['All', 'Single Digit', 'Jodi Digit', 'Panna'];

  final Color primaryColor = const Color(0xFF1A237E); // Deep blue
  final Color accentColor = const Color(0xFF303F9F); // Light blue
  final Color filterCardColor = Colors.white;
  final Color inputFillColor = Colors.grey.shade50;

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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(
              "Winning Report",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            pinned: true,
            floating: true,
            elevation: 4,
            expandedHeight: 60,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, accentColor],
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(),
                  const SizedBox(height: 16),
                  _buildDataTable(),
                  _buildPaginationControls(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Winning History",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildModernFilterCard(),
      ],
    );
  }

  Widget _buildModernFilterCard() {
    return Container(
      decoration: BoxDecoration(
        color: filterCardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            Icon(Icons.filter_alt_rounded, color: primaryColor),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildModernDateFilter(),
                    _buildModernDropdownFilter('Game Name', controller.gameName,
                        gameList, Icons.casino),
                    _buildModernDropdownFilter('Game Session',
                        controller.gameSession, sessionList, Icons.access_time),
                    _buildModernDropdownFilter('Game Type', controller.gameType,
                        typeList, Icons.grid_view),
                    _buildModernTextFieldFilter(
                        'Username', controller.username, Icons.person_outline),
                    _buildModernTextFieldFilter(
                        'Phone', controller.phone, Icons.phone_android),
                  ],
                ),
                const SizedBox(height: 16),
                _buildModernActionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDateFilter() {
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
          InkWell(
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
                color: inputFillColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 15, color: primaryColor),
                  const SizedBox(width: 12),
                  Text(
                    DateFormat('MMM dd, yyyy')
                        .format(controller.selectedDate.value),
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDropdownFilter(
      String label, RxString selected, List<String> items, IconData icon) {
    return SizedBox(
      width: 180, // Increased from 140 to accommodate content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Prevent vertical expansion
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
          DropdownButtonFormField<String>(
            isExpanded: true, // This is crucial to prevent overflow
            value: selected.value.isEmpty ? items[0] : selected.value,
            onChanged: (val) => selected.value = val ?? '',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12, // Reduced padding to save space
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: inputFillColor,
            ),
            dropdownColor: Colors.white,
            icon:
                const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.poppins(fontSize: 12),
                        overflow: TextOverflow.ellipsis, // Handle long text
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextFieldFilter(
      String label, RxString value, IconData icon) {
    return SizedBox(
      width: 120,
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
          TextFormField(
            onChanged: (val) => value.value = val,
            style:
                GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade800),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 15, color: primaryColor),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: inputFillColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: controller.filterData,
            icon: const Icon(Icons.search, size: 20),
            label: Text(
              'Search',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: controller.resetFilters,
            icon: const Icon(Icons.refresh, size: 20),
            label: Text(
              'Reset',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                'Loading winning data...',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.winData.isEmpty) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_outlined,
                    size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No winning records found',
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
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (states) => primaryColor.withOpacity(0.05),
              ),
              columnSpacing: 24,
              dataRowHeight: 56,
              headingRowHeight: 56,
              horizontalMargin: 16,
              columns: [
                _buildDataColumn("#", 60),
                _buildDataColumn("DATE", 120),
                _buildDataColumn("PHONE", 140),
                _buildDataColumn("USERNAME", 140),
                _buildDataColumn("GAME", 140),
                _buildDataColumn("TYPE", 140),
                _buildDataColumn("OPEN P", 100),
                _buildDataColumn("OPEN D", 100),
                _buildDataColumn("CLOSE P", 100),
                _buildDataColumn("CLOSE D", 100),
                _buildDataColumn("AMOUNT", 120),
                _buildDataColumn("POINTS", 100),
              ],
              rows: List.generate(
                controller.winData.length,
                (index) {
                  final row = controller.winData[index];
                  return DataRow(
                    cells: [
                      _buildDataCell("${index + 1}"),
                      _buildDataCell(row['date'] ?? ''),
                      _buildDataCell(row['userPhone'] ?? ''),
                      _buildDataCell(row['username'] ?? ''),
                      _buildDataCell(row['gameName'] ?? ''),
                      _buildDataCell(row['gameType'] ?? ''),
                      _buildDataCell(row['openPanna'] ?? ''),
                      _buildDataCell(row['openDigit'] ?? ''),
                      _buildDataCell(row['closePanna'] ?? ''),
                      _buildDataCell(row['closeDigit'] ?? ''),
                      _buildDataCell(row['winningAmount'] ?? '',
                          isAmount: true),
                      _buildDataCell(row['points'] ?? ''),
                    ],
                  );
                },
              ),
            ),
          ));
    });
  }

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left,
                color: controller.currentPage.value > 1
                    ? primaryColor
                    : Colors.grey),
            onPressed: controller.currentPage.value > 1
                ? controller.previousPage
                : null,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
              style: GoogleFonts.poppins(
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right,
                color:
                    controller.currentPage.value < controller.totalPages.value
                        ? primaryColor
                        : Colors.grey),
            onPressed:
                controller.currentPage.value < controller.totalPages.value
                    ? controller.nextPage
                    : null,
          ),
        ],
      ),
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
}
