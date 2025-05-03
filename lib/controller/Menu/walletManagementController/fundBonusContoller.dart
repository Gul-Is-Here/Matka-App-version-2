import 'package:get/get.dart';

class FundBonusController extends GetxController {
  var allBonuses = <Map<String, dynamic>>[].obs;
  var rowsPerPage = 10.obs;
  var currentPage = 1.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData() {
    allBonuses.value = List.generate(100, (index) {
      return {
        'id': index + 1,
        'amount': 100 + (index * 10),
        'bonus': (5 + (index % 5) * 2).toDouble(),
      };
    });
  }

  List<Map<String, dynamic>> get filteredData {
    if (searchQuery.value.isEmpty) return allBonuses;
    return allBonuses.where((entry) {
      return entry['amount'].toString().contains(searchQuery.value) ||
          entry['bonus'].toString().contains(searchQuery.value);
    }).toList();
  }

  List<Map<String, dynamic>> get paginatedData {
    final data = filteredData;
    final start = (currentPage.value - 1) * rowsPerPage.value;
    final end = start + rowsPerPage.value;
    return data.skip(start).take(rowsPerPage.value).toList();
  }

  void nextPage() {
    final maxPage = (filteredData.length / rowsPerPage.value).ceil();
    if (currentPage.value < maxPage) currentPage.value++;
  }

  void prevPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void deleteBonus(int id) {
    allBonuses.removeWhere((e) => e['id'] == id);
  }

  void addBonus(int amount, double bonus) {
    allBonuses.insert(0, {'id': allBonuses.length + 1, 'amount': amount, 'bonus': bonus});
  }
}
