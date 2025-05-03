import 'package:get/get.dart';

class BidWinningReportController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var gameName = ''.obs;
  var username = ''.obs;
  var phone = ''.obs;
  var totalBid = '₹487'.obs;
  var totalWin = '₹0'.obs;
  var totalProfit = '₹487'.obs;

  final bids = [].obs;
  final wins = [].obs;
}