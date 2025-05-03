import 'package:get/get.dart';

class CustomerSellReportController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedGame = ''.obs;
  var formData = {}.obs;

  void clearForm() {
    formData.clear();
  }
}