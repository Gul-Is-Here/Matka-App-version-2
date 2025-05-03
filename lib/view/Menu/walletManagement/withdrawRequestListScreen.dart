import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/Menu/walletManagementController/withdrawRequestListController.dart'
    show WithdrawRequestListController;

class WithdrawRequestListScreen extends StatelessWidget {
  WithdrawRequestListScreen({super.key});
  final controller = Get.put(WithdrawRequestListController());
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Withdraw Request List',
            style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        actions: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              children: [
                _buildFilterBar(),
                const SizedBox(height: 12),
                _buildSummaryCards(),
                const SizedBox(height: 12),
                _buildTableHeader(),
                const SizedBox(height: 8),
                Expanded(child: _buildDataTable()),
                _buildPagination(),
              ],
            )),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(
                text: controller.selectedDate.value.toString().split(' ')[0]),
            onTap: () async {
              final picked = await showDatePicker(
                context: Get.context!,
                initialDate: controller.selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) controller.selectedDate.value = picked;
            },
            decoration: const InputDecoration(
                labelText: 'Date', border: OutlineInputBorder()),
          ),
        ),
        _filterTextField('Username', controller.username),
        _filterTextField('Mobile No.', controller.phone),
        _filterTextField('Page', controller.page, isNumeric: true),
      ],
    );
  }

  Widget _filterTextField(String label, Rx value, {bool isNumeric = false}) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        keyboardType: isNumeric ? TextInputType.number : null,
        onChanged: (val) {
          value.value = isNumeric ? int.tryParse(val) ?? 1 : val;
          controller.applyFilters();
        },
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Total Withdraw Amount: ₹1356221",
            style: GoogleFonts.poppins(color: Colors.black)),
        Text("Total Approved Withdraw Amount: ₹1259332",
            style: GoogleFonts.poppins(color: Colors.green)),
        Text("Total Rejected Withdraw Amount: ₹181879",
            style: GoogleFonts.poppins(color: Colors.red)),
        Text("Total Pending Withdraw Amount: ₹15010",
            style: GoogleFonts.poppins(color: Colors.orange)),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<int>(
          value: controller.rowsPerPage.value,
          items: [10, 20, 50]
              .map((e) =>
                  DropdownMenuItem(value: e, child: Text("Show $e entries")))
              .toList(),
          onChanged: (val) => controller.rowsPerPage.value = val!,
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(primaryColor.withOpacity(0.1)),
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("DATE")),
          DataColumn(label: Text("USERNAME")),
          DataColumn(label: Text("USER MOBILE NO.")),
          DataColumn(label: Text("AMOUNT")),
          DataColumn(label: Text("WALLET")),
          DataColumn(label: Text("STATUS")),
          DataColumn(label: Text("VIEW")),
          DataColumn(label: Text("APPROVE")),
          DataColumn(label: Text("REJECT")),
        ],
        rows: controller.paginatedData.map((row) {
          final id = row['id'];
          final status = row['status'];

          return DataRow(cells: [
            DataCell(Text(id.toString())),
            DataCell(Text(row['date'])),
            DataCell(Text(row['username'])),
            DataCell(Text(row['phone'])),
            DataCell(Text(row['amount'])),
            DataCell(Text(row['wallet'])),
            DataCell(_statusChip(status)),
            DataCell(IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () => controller.viewRequest(id))),
            DataCell(status == 'PENDING'
                ? _actionBtn("Approve", Colors.green,
                    () => controller.approveRequest(id))
                : const Text("NA")),
            DataCell(status == 'PENDING'
                ? _actionBtn(
                    "Reject", Colors.red, () => controller.rejectRequest(id))
                : const Text("NA")),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color = status == 'APPROVED'
        ? Colors.green
        : status == 'REJECTED'
            ? Colors.red
            : Colors.orange;

    return Chip(
      label: Text(status),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _actionBtn(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.page.value--,
              icon: const Icon(Icons.chevron_left)),
          Obx(() => Text("Page ${controller.page.value}")),
          IconButton(
              onPressed: () => controller.page.value++,
              icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
