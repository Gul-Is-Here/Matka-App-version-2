import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalDepositController extends GetxController {
  final RxInt entriesPerPage = 10.obs;
  final RxInt currentPage = 1.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedTransactionType = 'All'.obs;
  final RxString selectedTransactionStatus = 'All'.obs;

  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> transactions = [
    // Add your transaction data here
    // Example:
    // {
    //   'username': 'user1',
    //   'phone': '1234567890',
    //   'amount': 1000,
    //   'status': 'Pending',
    //   'type': 'Deposit',
    //   'date': DateTime.now(),
    //   'details': 'Transaction details...',
    // },
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    var results = transactions.where((transaction) {
      final matchesSearch = searchQuery.isEmpty ||
          transaction['username']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          transaction['phone'].toString().contains(searchQuery);

      final matchesType = selectedTransactionType.value == 'All' ||
          transaction['type'].toString() == selectedTransactionType.value;

      final matchesStatus = selectedTransactionStatus.value == 'All' ||
          transaction['status'].toString() == selectedTransactionStatus.value;

      return matchesSearch && matchesType && matchesStatus;
    }).toList();

    return results;
  }

  List<Map<String, dynamic>> get paginatedTransactions {
    final start = (currentPage.value - 1) * entriesPerPage.value;
    final end = start + entriesPerPage.value;
    return filteredTransactions.sublist(
      start.clamp(0, filteredTransactions.length),
      end.clamp(0, filteredTransactions.length),
    );
  }

  String get currentDate {
    return DateFormat('MM/dd/yyyy').format(DateTime.now());
  }
}
