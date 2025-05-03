import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Menu/UserDetails/userDetailsController.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Admin'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(controller),
            const SizedBox(height: 24),
            const Text('User List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Obx(() => _buildUserListTable(controller)),
            const SizedBox(height: 32),
            const Text('Source List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildSourceListTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(UserController controller) {
    return Column(
      children: [
        Row(
          children: [
            _textField('Username', controller.searchText),
            const SizedBox(width: 10),
            _textField('Mobile No', RxString('')),
            const SizedBox(width: 10),
            _dropdownField('Transfer', controller.transferFilter,
                ['All', 'Yes', 'No'], controller),
            const SizedBox(width: 10),
            _dropdownField('Status', controller.statusFilter,
                ['All', 'Verified', 'Not Verified'], controller),
          ],
        ),
      ],
    );
  }

  Widget _textField(String label, RxString boundValue) {
    return Expanded(
      child: TextFormField(
        onChanged: (val) {
          boundValue.value = val;
          Get.find<UserController>().applyFilters();
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  Widget _dropdownField(String label, RxString selected, List<String> items,
      UserController controller) {
    return Expanded(
      child: Obx(() => DropdownButtonFormField<String>(
            value: selected.value,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (val) {
              selected.value = val!;
              controller.applyFilters();
            },
          )),
    );
  }

  Widget _buildUserListTable(UserController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: DataTable(
            columnSpacing: 12,
            columns: const [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Mobile Number')),
              DataColumn(label: Text('Date/Last Seen')),
              DataColumn(label: Text('Balance')),
              DataColumn(label: Text('Transfer')),
              DataColumn(label: Text('Active')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('View')),
            ],
            rows: List.generate(controller.paginatedUsers.length, (index) {
              final user = controller.paginatedUsers[index];
              return DataRow(cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(user.name)),
                DataCell(Text(user.mobile)),
                DataCell(Text(user.lastSeen)),
                DataCell(Text('${user.balance}')),
                DataCell(_badge(user.transfer, Colors.red)),
                DataCell(_badge(user.active, Colors.green)),
                DataCell(_badge(user.status, Colors.green)),
                DataCell(const Icon(Icons.remove_red_eye_outlined)),
              ]);
            }),
          )),
    );
  }

  Widget _buildSourceListTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: DataTable(
          columnSpacing: 12,
          columns: const [
            DataColumn(label: Text('#')),
            DataColumn(label: Text('Version Name')),
            DataColumn(label: Text('Total Install')),
            DataColumn(label: Text('Current Install')),
          ],
          rows: List.generate(10, (index) {
            return DataRow(cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text('Version ${index + 1}.0')),
              DataCell(_badge('10', Colors.blue)),
              DataCell(_badge('${(index + 1) * 10}', Colors.purple)),
            ]);
          }),
        ),
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style:
            TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
