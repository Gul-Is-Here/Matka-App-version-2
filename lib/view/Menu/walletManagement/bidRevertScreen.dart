import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/Menu/walletManagementController/bidRevertController.dart' show BidRevertController;


class BidRevertScreen extends StatelessWidget {
  BidRevertScreen({super.key});
  final controller = Get.put(BidRevertController());
  final List<String> gameNames = ["All", "MILAN NIGHT", "SRIDEVI NIGHT"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Bid Revert', style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterBar(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.revertBid,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Revert Bid"),
                ),
                const SizedBox(height: 16),
                _buildTableControls(),
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
      spacing: 12,
      runSpacing: 12,
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text: controller.selectedDate.value.toString().split(' ')[0],
            ),
            onTap: () async {
              final picked = await showDatePicker(
                context: Get.context!,
                initialDate: controller.selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) controller.selectedDate.value = picked;
            },
            decoration: const InputDecoration(labelText: "Date", border: OutlineInputBorder()),
          ),
        ),
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            value: controller.selectedGameName.value,
            decoration: const InputDecoration(labelText: "Game Name", border: OutlineInputBorder()),
            onChanged: (val) => controller.selectedGameName.value = val!,
            items: gameNames.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: controller.loadDummyData,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text("Submit"),
        ),
        ElevatedButton(
          onPressed: controller.resetFilters,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Clear"),
        ),
      ],
    );
  }

  Widget _buildTableControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<int>(
          value: controller.rowsPerPage.value,
          items: [10, 20, 50].map((e) => DropdownMenuItem(value: e, child: Text("Show $e entries"))).toList(),
          onChanged: (val) => controller.rowsPerPage.value = val!,
        ),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (val) => controller.searchText.value = val,
            decoration: const InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    final rows = controller.paginatedData;
    if (rows.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith((_) => Colors.blue.shade50),
        columns: const [
          DataColumn(label: Text("#")),
          DataColumn(label: Text("DATE")),
          DataColumn(label: Text("USERNAME")),
          DataColumn(label: Text("GAME NAME")),
          DataColumn(label: Text("GAME TYPE")),
          DataColumn(label: Text("OPEN")),
          DataColumn(label: Text("CLOSE")),
          DataColumn(label: Text("BIDDED POINTS")),
        ],
        rows: rows.map((row) {
          return DataRow(cells: [
            DataCell(Text(row['id'].toString())),
            DataCell(Text(row['date'])),
            DataCell(Text(row['username'])),
            DataCell(Text(row['gameName'])),
            DataCell(Text(row['gameType'])),
            DataCell(Text(row['open'].toString())),
            DataCell(Text(row['close'].toString())),
            DataCell(Text(row['points'].toString())),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: controller.previousPage, icon: const Icon(Icons.chevron_left)),
          Obx(() => Text("Page ${controller.currentPage.value}")),
          IconButton(onPressed: controller.nextPage, icon: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
