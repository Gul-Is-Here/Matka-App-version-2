// controllers/payment_config_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentConfigController extends GetxController {
  // Payment Gateway Normal
  var upiLowerAmountLimit = 600.obs;
  var upiStatus = 'Active'.obs;
  
  // Bank Account Details
  var bankName = 'Indexind'.obs;
  var accountHolderName = 'Kuldeep'.obs;
  var accountNumber = '12334567777777'.obs;
  var ifscCode = 'IND:000'.obs;
  var bankStatus = 'Active'.obs;
  
  // QR Code
  var qrImage = Rxn<File>();
  var qrImageUrl = 'https://imageldrc.co.in/uploaded/spingin/8_cum..._qr_code_PN353.jpg'.obs;
  var upiId = '9024252689-4@ybl'.obs;
  var qrStatus = 'Active'.obs;
  
  // Form controllers
  var bankNameController = TextEditingController();
  var accountHolderController = TextEditingController();
  var accountNumberController = TextEditingController();
  var ifscCodeController = TextEditingController();
  var upiIdController = TextEditingController();
  var amountLimitController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize form controllers with current values
    bankNameController.text = bankName.value;
    accountHolderController.text = accountHolderName.value;
    accountNumberController.text = accountNumber.value;
    ifscCodeController.text = ifscCode.value;
    upiIdController.text = upiId.value;
    amountLimitController.text = upiLowerAmountLimit.value.toString();
  }

  Future<void> pickQRImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      qrImage.value = File(pickedFile.path);
      qrImageUrl.value = pickedFile.path;
    }
  }

  void updateBankDetails() {
    bankName.value = bankNameController.text;
    accountHolderName.value = accountHolderController.text;
    accountNumber.value = accountNumberController.text;
    ifscCode.value = ifscCodeController.text;
    Get.back(); // Close the edit dialog
    Get.snackbar('Success', 'Bank details updated');
  }

  void updateUPIDetails() {
    upiId.value = upiIdController.text;
    Get.back();
    Get.snackbar('Success', 'UPI ID updated');
  }

  void updateAmountLimit() {
    upiLowerAmountLimit.value = int.tryParse(amountLimitController.text) ?? 600;
    Get.back();
    Get.snackbar('Success', 'Amount limit updated');
  }

  void toggleUPIStatus() {
    upiStatus.value = upiStatus.value == 'Active' ? 'Inactive' : 'Active';
  }

  void toggleBankStatus() {
    bankStatus.value = bankStatus.value == 'Active' ? 'Inactive' : 'Active';
  }

  void toggleQRStatus() {
    qrStatus.value = qrStatus.value == 'Active' ? 'Inactive' : 'Active';
  }

  @override
  void onClose() {
    bankNameController.dispose();
    accountHolderController.dispose();
    accountNumberController.dispose();
    ifscCodeController.dispose();
    upiIdController.dispose();
    amountLimitController.dispose();
    super.onClose();
  }
}