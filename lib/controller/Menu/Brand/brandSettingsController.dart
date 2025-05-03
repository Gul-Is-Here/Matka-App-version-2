// controllers/brand_settings_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandSettingsController extends GetxController {
  // Settings values
  var settings = <String, String>{
    'Banner Marquee': 'WELCOME TO INDIA NO.1 TRUSTED KALYAN MATKA APPLICA',
    'Email 1': 'satiamatka@gmail.com',
    'Mobile No 1': '',
    'Mobile No 2': '',
    'Telegram No': '',
    'Whatsapp No': '',
    'Withdraw Proof': '',
  }.obs;

  // Dashboard items
  var dashboardItems = [
    'App Setting',
    'Payment Setting',
    'More Setting',
    'Markets',
    'Vip Section',
    'User Details',
    'Report Management',
    'Wallet Management',
    'Notice Management',
    'Web Setting',
    'Admin & Roles Modules',
  ].obs;

  // Text editing controllers
  var editingControllers = <String, TextEditingController>{};

  @override
  void onInit() {
    super.onInit();
    // Initialize editing controllers
    for (var key in settings.keys) {
      editingControllers[key] = TextEditingController(text: settings[key]);
    }
  }

  void updateSetting(String key) {
    settings[key] = editingControllers[key]!.text;
    Get.back();
    Get.snackbar('Success', '$key updated successfully');
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var controller in editingControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}