import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WithdrawRequestListController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var username = ''.obs;
  var phone = ''.obs;
  var page = 1.obs;
  var totalPages = 23.obs;

  var rowsPerPage = 10.obs;
  var allData = <Map<String, dynamic>>[].obs;
  var filteredData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    allData.value = List.generate(230, (index) {
      return {
        'date': DateFormat('MMM dd, yyyy hh:mm a')
            .format(DateTime.now().subtract(Duration(days: index))),
        'username': index % 3 == 0
            ? 'VIP User'
            : index % 2 == 0
                ? 'john snow'
                : 'Kumar',
        'phone': '98765432${index % 10}0',
        'amount': '1000',
        'wallet': '${1000 + index * 2}',
        'status': index % 3 == 0 ? 'APPROVED' : 'PENDING',
        'id': index + 1,
      };
    });
    applyFilters();
  }

  void applyFilters() {
    List<Map<String, dynamic>> filtered = allData.where((row) {
      final uname = username.value.trim().toLowerCase();
      final ph = phone.value.trim();
      return (uname.isEmpty || row['username'].toLowerCase().contains(uname)) &&
          (ph.isEmpty || row['phone'].contains(ph));
    }).toList();

    filteredData.value = filtered;
  }

  void approveRequest(int id) => print('Approved $id');
  void rejectRequest(int id) => print('Rejected $id');
  void viewRequest(int id) => print('View $id');

  List<Map<String, dynamic>> get paginatedData {
    final start = (page.value - 1) * rowsPerPage.value;
    final end = start + rowsPerPage.value;
    return filteredData.skip(start).take(rowsPerPage.value).toList();
  }

  int get totalApproved =>
      allData.where((e) => e['status'] == 'APPROVED').length;
  int get totalPending => allData.where((e) => e['status'] == 'PENDING').length;
  int get totalRejected =>
      allData.where((e) => e['status'] == 'REJECTED').length;
}
