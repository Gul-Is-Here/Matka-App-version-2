import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/Menu/walletManagementController/fundBonusContoller.dart'
    show FundBonusController;

class FundBonusScreen extends StatelessWidget {
  FundBonusScreen({super.key});
  final controller = Get.put(FundBonusController());
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Fund Bonus'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => _showAddDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Add Fund Bonus"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderControls(),
                const SizedBox(height: 12),
                Expanded(child: _buildTable()),
                _buildPagination(),
              ],
            )),
      ),
    );
  }

  Widget _buildHeaderControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<int>(
          value: controller.rowsPerPage.value,
          onChanged: (val) => controller.rowsPerPage.value = val!,
          items: [10, 20, 50].map((e) {
            return DropdownMenuItem(value: e, child: Text("Show $e entries"));
          }).toList(),
        ),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (val) => controller.searchQuery.value = val,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    final data = controller.paginatedData;

    if (data.isEmpty) {
      return const Center(child: Text("No data available in table"));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all(primaryColor.withOpacity(0.1)),
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("AMOUNT")),
          DataColumn(label: Text("BONUS (%)")),
          DataColumn(label: Text("ACTION")),
        ],
        rows: List.generate(data.length, (index) {
          final row = data[index];
          return DataRow(cells: [
            DataCell(Text("${row['id']}")),
            DataCell(Text("${row['amount']}")),
            DataCell(Text("${row['bonus']}")),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteBonus(row['id']),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: controller.prevPage,
            icon: const Icon(Icons.chevron_left)),
        Obx(() => Text("Page ${controller.currentPage.value}")),
        IconButton(
            onPressed: controller.nextPage,
            icon: const Icon(Icons.chevron_right)),
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    final amountController = TextEditingController();
    final bonusController = TextEditingController();

    Get.defaultDialog(
      title: "Add Fund Bonus",
      titleStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      content: Column(
        children: [
          TextFormField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: bonusController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Bonus %"),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          final amount = int.tryParse(amountController.text);
          final bonus = double.tryParse(bonusController.text);
          if (amount != null && bonus != null) {
            controller.addBonus(amount, bonus);
            Get.back();
          } else {
            Get.snackbar("Error", "Please enter valid values",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
        child: const Text("Add"),
      ),
      cancel: TextButton(onPressed: Get.back, child: const Text("Cancel")),
    );
  }
}
