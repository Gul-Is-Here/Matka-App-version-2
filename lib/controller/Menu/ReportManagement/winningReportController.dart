import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WinningReportController extends GetxController {
  // Filter variables
  var selectedDate = DateTime.now().obs;
  var gameName = ''.obs;
  var gameSession = ''.obs;
  var gameType = ''.obs;
  var username = ''.obs;
  var phone = ''.obs;

  // Pagination variables
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var itemsPerPage = 10.obs;

  // State variables
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Data list
  final RxList winData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWinningData();
  }

  Future<void> fetchWinningData() async {
    try {
      isLoading(true);
      hasError(false);

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Replace with actual API call
      // final response = await yourApiService.getWinningData(
      //   date: selectedDate.value,
      //   gameName: gameName.value,
      //   gameSession: gameSession.value,
      //   gameType: gameType.value,
      //   username: username.value,
      //   phone: phone.value,
      //   page: currentPage.value,
      //   limit: itemsPerPage.value,
      // );

      // Mock data - replace with your actual data fetching logic
      winData.value = List.generate(
          15,
          (index) => {
                'date': DateFormat('dd-MM-yyyy')
                    .format(DateTime.now().subtract(Duration(days: index))),
                'userPhone': '9876543${index.toString().padLeft(2, '0')}',
                'username': 'user${index + 1}',
                'gameName': [
                  'KALYAN',
                  'TIME BAZAR',
                  'SRIDEVI MORNING'
                ][index % 3],
                'gameType': ['Single Digit', 'Jodi Digit', 'Panna'][index % 3],
                'openPanna': '12${index % 10}',
                'openDigit': '${index % 10}',
                'closePanna': '45${index % 10}',
                'closeDigit': '${(index + 2) % 10}',
                'winningAmount': (index * 1000).toString(),
                'points': (index * 10).toString(),
              });

      // For pagination - set this from your API response
      totalPages.value = 3; // Replace with actual total pages from API
    } catch (e) {
      hasError(true);
      errorMessage.value = 'Failed to load data: ${e.toString()}';
      winData.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    currentPage.value = 1;
    await fetchWinningData();
  }

  void filterData() {
    currentPage.value = 1;
    fetchWinningData();
  }

  void resetFilters() {
    selectedDate.value = DateTime.now();
    gameName.value = '';
    gameSession.value = '';
    gameType.value = '';
    username.value = '';
    phone.value = '';
    currentPage.value = 1;
    fetchWinningData();
  }

  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      fetchWinningData();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      fetchWinningData();
    }
  }

  // Optional: Add debounce for search fields if needed
  void debounceFilter() {
    debounce(
      [username, phone] as RxInterface<Object?>,
      (_) => filterData(),
      time: const Duration(milliseconds: 500),
    );
  }
}
