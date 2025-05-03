import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // UPI Payment Settings
  final upiIdController = TextEditingController(text: '8618192021@kbl');
  final upiNameController = TextEditingController(text: 'matka app');

  // Time Settings
  final marketOpenTime = '08:00 AM'.obs;
  final playOpenTime = '12:00 AM'.obs;

  // Amount Settings
  final minDeposit = 2.obs;
  final maxDeposit = 100001.obs;
  final minWithdraw = 1000.obs;
  final maxWithdraw = 10001.obs;
  final minBidAmount = 11.obs;
  final maxBidAmount = 10001.obs;
  final bidCloseTime = '11:05 PM'.obs;
  final minTransfer = 3.obs;
  final maxTransfer = 1001.obs;
  final joiningBonus = 50.obs;

  // Withdrawal Settings
  final allowSundayWithdraw = false.obs;
  final allowSaturdayWithdraw = false.obs;

  // App Details
  final appLinkController =
      TextEditingController(text: 'https://play.google.com/store/s');
  final sponsorLinkController =
      TextEditingController(text: 'https://development.smapidev');
  final shareMessageController = TextEditingController(text: 'share message');
  final adminMessageController = TextEditingController(text: 'Admin Message');

  // Messages
  final addFundMessageController = TextEditingController(
    text:
        'MINIMUM DEPOSIT 300\n5% DEPOSIT BONUS ON 1000\n8% DEPOSIT BONUS ON 2500\n10% DEPOSIT BONUS ON 5000',
  );
  final withdrawMessageController = TextEditingController(
    text: 'PLEASE FILL YOUR BANK ACCOUNT DETAILS FOR FAST WITHDRAW',
  );

  // App Links
  final appLink1Controller =
      TextEditingController(text: 'https://development.smapidev');
  final appLink2Controller =
      TextEditingController(text: 'https://development.smapidev');
  final appLink3Controller = TextEditingController(text: 'Live');

  // App Messages
  final appNoticeMessageController = TextEditingController(
    text:
        'WELCOME TO INDIA\'S NO. 1 TRUSTED ONLINE MATKA APP\nKALYAN RATAN MATKA\nMINIMUM DEPOSIT – 300',
  );
  final welcomeMessageController = TextEditingController(
    text:
        'Welcome to India\'s No.1 Trusted Online Matka App\nKalyan Ratan Matka\nMinimum Deposit: ₹300\nMinimum Withdrawal: ₹1000',
  );

  @override
  void onClose() {
    upiIdController.dispose();
    upiNameController.dispose();
    appLinkController.dispose();
    sponsorLinkController.dispose();
    shareMessageController.dispose();
    adminMessageController.dispose();
    addFundMessageController.dispose();
    withdrawMessageController.dispose();
    appLink1Controller.dispose();
    appLink2Controller.dispose();
    appLink3Controller.dispose();
    appNoticeMessageController.dispose();
    welcomeMessageController.dispose();
    super.onClose();
  }

  void saveSettings() {
    // Implement save to backend here
    Get.snackbar(
      'Success',
      'Settings saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
