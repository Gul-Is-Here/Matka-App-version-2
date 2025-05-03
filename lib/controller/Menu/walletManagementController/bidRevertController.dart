import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BidRevertController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var selectedGameName = 'All'.obs;
  var searchText = ''.obs;
  var currentPage = 1.obs;
  var rowsPerPage = 10.obs;

  var allBids = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    allBids.value = List.generate(89, (index) {
      return {
        "id": index + 1,
        "date": "19-04-2025",
        "username": index % 2 == 0 ? "Raj" : "Kumar",
        "gameName": index % 2 == 0 ? "MILAN NIGHT" : "SRIDEVI NIGHT",
        "gameType": index % 2 == 0 ? "Double Panna" : "Full Sangam",
        "open": 100 + index,
        "close": 110 + index,
        "points": 11,
      };
    });
  }

  void resetFilters() {
    selectedDate.value = DateTime.now();
    selectedGameName.value = 'All';
    searchText.value = '';
    currentPage.value = 1;
  }

  List<Map<String, dynamic>> get filteredData {
    return allBids.where((bid) {
      final matchesGame = selectedGameName.value == 'All' || bid['gameName'] == selectedGameName.value;
      final matchesSearch = searchText.value.isEmpty ||
          bid['username'].toLowerCase().contains(searchText.value.toLowerCase());
      return matchesGame && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get paginatedData {
    final start = (currentPage.value - 1) * rowsPerPage.value;
    final end = start + rowsPerPage.value;
    return filteredData.skip(start).take(rowsPerPage.value).toList();
  }

  void nextPage() {
    final maxPage = (filteredData.length / rowsPerPage.value).ceil();
    if (currentPage.value < maxPage) currentPage.value++;
  }

  void previousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void revertBid() {
    // Revert logic here
    Get.snackbar("Success", "Bids reverted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary);
  }
}
