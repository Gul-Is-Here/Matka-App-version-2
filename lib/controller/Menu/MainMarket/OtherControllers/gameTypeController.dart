import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameRateController extends GetxController {
  final value1 = <String, TextEditingController>{};
  final value2 = <String, TextEditingController>{};
  var isSubmitting = false.obs;

  final gameFields = [
    'Single Digit',
    'Jodi Digit',
    'Single Panna',
    'Double Panna',
    'Triple Panna',
    'Half Sangam',
    'Full Sangam',
  ];

  @override
  void onInit() {
    super.onInit();
    for (var field in gameFields) {
      value1[field] = TextEditingController(text: '10');
      value2[field] = TextEditingController(text: '100');
    }
  }

//  Future<void> submit() async {
//     try {
//       isSubmitting.value = true;
//       // Your submission logic here
//       await Future.delayed(1.seconds); // Simulate network request
//       isSubmitting.value = false;
//       Get.snackbar('Success', 'Game rates added successfully');
//     } catch (e) {
//       isSubmitting.value = false;
//       Get.snackbar('Error', 'Failed to add game rates');
//     }
//   }
  void submit() {
    for (var field in gameFields) {
      debugPrint('$field: ${value1[field]!.text} - ${value2[field]!.text}');
    }
  }
}
