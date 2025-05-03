import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawFundListController extends GetxController {
  final userList = [
    {
      'name': 'Pulkit Sharma',
      'phone': '6631772738',
      'availablePoints': 3442684,
    },
    {
      'name': 'Amit Patel',
      'phone': '9845632189',
      'availablePoints': 125000,
    },
  ].obs;

  RxMap<String, dynamic>? selectedUser = RxMap<String, dynamic>();
  RxString pointInput = ''.obs;
  final formKey = GlobalKey<FormState>();

  void submit() {
    if (formKey.currentState!.validate() && selectedUser?.isNotEmpty == true) {
      final user = selectedUser!;
      Get.snackbar(
        "Submitted",
        "Assigned ${pointInput.value} points to ${user['name']}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please select user and enter valid points",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }
}
