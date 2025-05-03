import 'package:get/get.dart';

class AutoDepositController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var username = ''.obs;
  var phone = ''.obs;
  var status = 'All'.obs;
  var rows = [].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      hasError(false);
      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));

      // Replace this with your actual data fetching logic
      rows.value = [
        {
          'username': 'user1',
          'phone': '1234567890',
          'amount': '100.00',
          'status': 'Success',
          'date': '2023-06-15'
        },
        {
          'username': 'user2',
          'phone': '9876543210',
          'amount': '200.00',
          'status': 'Pending',
          'date': '2023-06-16'
        },
      ];
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      rows.value = [];
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  void filterData() {
    isLoading(true);
    try {
      // Implement your filtering logic here
      // This is a simple example that filters by status
      if (status.value != 'All') {
        rows.value =
            rows.where((row) => row['status'] == status.value).toList();
      } else {
        fetchData(); // Reset to all data if "All" is selected
      }
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Filter error: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }

  void resetFilters() {
    username.value = '';
    phone.value = '';
    status.value = 'All';
    selectedDate.value = DateTime.now();
    fetchData();
  }

  // Optional: Add debounce for search fields if needed
  void debounceFilter() {
    debounce(
      [username, phone] as RxInterface<Object?>,
      (_) => filterData(),
      time: Duration(milliseconds: 500),
    );
  }
}
