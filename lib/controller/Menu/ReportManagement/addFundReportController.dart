import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddFundReportController extends GetxController {
  // Filter variables
  var selectedDate = DateTime.now().obs;
  var username = ''.obs;
  var phone = ''.obs;
  var transactionType = 'All'.obs;
  var transactionStatus = 'All'.obs;
  final RxInt currentPage = 1.obs;
  final RxInt rowsPerPage = 10.obs;
  // Data variables
  var rows = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  List<String> typeOptions = ['All', 'Credit', 'Debit'];
  List<String> statusOptions = ['All', 'Success', 'Pending', 'Failed'];
  // Debounce timer for search
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void debounceFilter() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), filterData);
  }

  List<Map<String, dynamic>> get paginatedRows {
    final start = (currentPage.value - 1) * rowsPerPage.value;
    final end = (start + rowsPerPage.value).clamp(0, rows.length);
    return rows.sublist(start, end);
  }

  int get totalPages => (rows.length / rowsPerPage.value)
      .ceil()
      .clamp(1, double.infinity)
      .toInt();

  void nextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      hasError(false);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API call
      rows.value = List.generate(15, (index) {
        final types = ['Credit', 'Debit'];
        final statuses = ['Success', 'Pending', 'Failed'];
        final randomType = types[index % types.length];
        final randomStatus = statuses[index % statuses.length];

        return {
          'username': 'user${index + 1}',
          'phone': '+1${5550000000 + index}',
          'amount': (100 + index * 23.5),
          'type': randomType,
          'status': randomStatus,
          'date': DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: index))),
          'reference': 'REF-${DateTime.now().millisecondsSinceEpoch + index}',
        };
      });

      filterData(); // Apply initial filters
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Failed to load data: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  void filterData() {
    try {
      var filtered = [
        ...rows
      ]; // Start with all data (in a real app, this would be from API)

      // Apply filters
      if (username.isNotEmpty) {
        filtered = filtered
            .where((item) => item['username']
                .toString()
                .toLowerCase()
                .contains(username.value.toLowerCase()))
            .toList();
      }

      if (phone.isNotEmpty) {
        filtered = filtered
            .where((item) => item['phone'].toString().contains(phone.value))
            .toList();
      }

      if (transactionType.value != 'All') {
        filtered = filtered
            .where((item) => item['type'] == transactionType.value)
            .toList();
      }

      if (transactionStatus.value != 'All') {
        filtered = filtered
            .where((item) => item['status'] == transactionStatus.value)
            .toList();
      }

      // Apply date filter (assuming we have date in the data)
      filtered = filtered
          .where((item) =>
              item['date'] ==
              DateFormat('yyyy-MM-dd').format(selectedDate.value))
          .toList();

      rows.assignAll(filtered);
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Filter error: ${e.toString()}';
    }
  }

  void resetFilters() {
    selectedDate.value = DateTime.now();
    username.value = '';
    phone.value = '';
    transactionType.value = 'All';
    transactionStatus.value = 'All';
    filterData();
  }

  void refreshData() {
    fetchData();
  }
}
