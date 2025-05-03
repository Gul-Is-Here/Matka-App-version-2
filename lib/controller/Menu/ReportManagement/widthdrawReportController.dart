import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WithdrawReportController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var username = ''.obs;
  var phone = ''.obs;
  var withdrawnBy = 'All'.obs;
  var transactionStatus = 'All'.obs;

  var rows = [].obs;
  var allData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData(); // Load initial mock data
  }

  void _loadDummyData() {
    allData.value = [
      {
        'username': 'Alice',
        'phone': '1234567890',
        'amount': '₹500',
        'by': 'User',
        'status': 'Success',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
      {
        'username': 'Bob',
        'phone': '9876543210',
        'amount': '₹1000',
        'by': 'Admin',
        'status': 'Pending',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      },
      {
        'username': 'Charlie',
        'phone': '4445556666',
        'amount': '₹250',
        'by': 'User',
        'status': 'Failed',
        'date': DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 1))),
      },
    ];
    rows.assignAll(allData);
  }

  void filterData() {
    final filterDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    rows.value = allData.where((row) {
      final matchDate = row['date'] == filterDate;
      final matchUsername = username.value.isEmpty ||
          row['username'].toLowerCase().contains(username.value.toLowerCase());
      final matchPhone =
          phone.value.isEmpty || row['phone'].contains(phone.value);
      final matchBy =
          withdrawnBy.value == 'All' || row['by'] == withdrawnBy.value;
      final matchStatus = transactionStatus.value == 'All' ||
          row['status'] == transactionStatus.value;
      return matchDate && matchUsername && matchPhone && matchBy && matchStatus;
    }).toList();
  }

  void resetFilters() {
    selectedDate.value = DateTime.now();
    username.value = '';
    phone.value = '';
    withdrawnBy.value = 'All';
    transactionStatus.value = 'All';
    rows.assignAll(allData);
  }
}
