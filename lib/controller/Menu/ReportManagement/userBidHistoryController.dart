import 'package:get/get.dart';

class BidHistoryController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var gameName = ''.obs;
  var gameType = ''.obs;
  var gameSession = ''.obs;
  var singleDigit = ''.obs;
  var jodiDigit = ''.obs;
  var panna = ''.obs;
  var username = ''.obs;
  var phone = ''.obs;
  var currentPage = 1.obs;
  var totalBidAmount = 429.obs;

  List<Map<String, dynamic>> get paginatedRows {
    // Simple pagination logic - in real app you'd want proper pagination
    final start = (currentPage.value - 1) * 10;
    final end = start + 10;
    return rows.sublist(start, end > rows.length ? rows.length : end);
  }

  int get totalPages => (rows.length / 10).ceil();

  final rows = List.generate(
      50,
      (i) => {
            'date': '${16 + i ~/ 10} Apr, 2025 12:4${i % 10} am',
            'user': i % 2 == 0 ? 'Raj' : 'Jemit',
            'gameName': i == 9
                ? 'CHENNAI EXPRESS'
                : i == 8
                    ? 'TIME BAZAR'
                    : 'SRIDEVI MORNING',
            'gameType': i == 8
                ? 'Jodi Digit'
                : i == 9
                    ? 'Single Panna'
                    : 'Single Digit',
            'session': i % 3 == 0
                ? 'Open'
                : i % 3 == 1
                    ? 'Close'
                    : 'Both',
            'openPanna': i == 9
                ? '678'
                : i == 8
                    ? '2'
                    : '${600 + i % 100}',
            'openDigit': i == 8 ? '0' : '${i % 10}',
            'closePanna': i % 3 == 1 ? '${100 + i % 100}' : '',
            'closeDigit': i % 3 == 1 ? '${i % 10}' : '',
            'points': '${40 + i % 10}',
          });

  void filterData() {
    // Implement your filter logic here
    // This would filter the rows based on the current filter values
    refresh(); // Refresh the UI
  }

  void resetFilters() {
    gameName.value = '';
    gameType.value = '';
    gameSession.value = '';
    singleDigit.value = '';
    jodiDigit.value = '';
    panna.value = '';
    username.value = '';
    phone.value = '';
    selectedDate.value = DateTime.now();
    currentPage.value = 1;
    refresh(); // Refresh the UI
  }
}
