import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddFundListController extends GetxController {
  final userList = [
    {
      'name': 'Bhupendra Maurya',
      'phone': '1234567890',
    },
    {
      'name': 'Amit Kumar',
      'phone': '9988776655',
    },
  ].obs;

  RxMap<String, dynamic>? selectedUser = RxMap<String, dynamic>();
  RxString amount = ''.obs;

  final formKey = GlobalKey<FormState>();

  void submitFund() {
    if (formKey.currentState!.validate() && selectedUser?.isNotEmpty == true) {
      final user = selectedUser!;
      final msg = "Added ₹${amount.value} to ${user['name']}";
      Get.snackbar("Success", msg,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Select a user and enter a valid amount",
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
