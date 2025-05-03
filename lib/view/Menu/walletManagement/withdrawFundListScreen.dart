import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/Menu/walletManagementController/withdrawFundRequestListController.dart'
    show WithdrawFundListController;

class WithdrawFundListScreen extends StatelessWidget {
  WithdrawFundListScreen({super.key});
  final controller = Get.put(WithdrawFundListController());
  final Color primaryColor = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Withdraw Fund Assignment", style: GoogleFonts.poppins()),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                          isExpanded: true,
                          value: controller.selectedUser?.isNotEmpty == true
                              ? controller.selectedUser
                              : null,
                          onChanged: (val) =>
                              controller.selectedUser?.value = val ?? {},
                          items: controller.userList.map((user) {
                            final label =
                                "${user['name']} - ${user['phone']} (Avl. Point: ${user['availablePoints']})";
                            return DropdownMenuItem(
                              value: user,
                              child: Text(label,
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          hint: const Text("Select User"),
                        )),
                    const SizedBox(height: 24),
                    Text("* Required Fields",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.red)),
                    const SizedBox(height: 8),
                    TextFormField(
                      onChanged: (val) => controller.pointInput.value = val,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Points are required';
                        }
                        if (int.tryParse(val) == null || int.parse(val) <= 0) {
                          return 'Enter a valid positive number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter Points",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text("* Required Fields",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.red)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text("Submit",
                            style: GoogleFonts.poppins(color: Colors.white)),
                      ),
                    ),
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
