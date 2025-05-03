import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/Menu/walletManagementController/addFundListController.dart' show AddFundListController;


class AddFundListScreen extends StatelessWidget {
  AddFundListScreen({super.key});
  final controller = Get.put(AddFundListController());
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Add Fund", style: GoogleFonts.poppins()),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("User", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                          isExpanded: true,
                          value: controller.selectedUser?.isNotEmpty == true
                              ? controller.selectedUser
                              : null,
                          onChanged: (val) => controller.selectedUser?.value = val ?? {},
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          items: controller.userList.map((user) {
                            final label = "${user['name']} - ${user['phone']}";
                            return DropdownMenuItem(
                              value: user,
                              child: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
                            );
                          }).toList(),
                          hint: const Text("Select User"),
                        )),
                    const SizedBox(height: 24),
                    Text("* Required Fields", style: GoogleFonts.poppins(fontSize: 12, color: Colors.red)),
                    const SizedBox(height: 8),
                    TextFormField(
                      onChanged: (val) => controller.amount.value = val,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Amount is required';
                        if (int.tryParse(val) == null || int.parse(val) <= 0) {
                          return 'Enter a valid amount';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Amount",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text("* Required Fields", style: GoogleFonts.poppins(fontSize: 12, color: Colors.red)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.submitFund,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("Add Fund", style: GoogleFonts.poppins(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
