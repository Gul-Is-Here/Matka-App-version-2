import 'package:get/get.dart';

class TransferReportController extends GetxController {
  var selectedDate = DateTime.now().obs;
  final RxList reportList = [].obs;
}
