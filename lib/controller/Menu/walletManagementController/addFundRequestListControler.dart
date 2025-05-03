import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundRequestListController extends GetxController {
  // Reactive variables
  final searchText = ''.obs;
  final currentPage = 1.obs;
  final rowsPerPage = 10.obs;
  final isLoading = false.obs;
  final selectedStatus = "ALL".obs;

  // Status filters
  final List<String> statusFilters = ["ALL", "PENDING", "APPROVED", "REJECTED"];

  // Main data list
  final fundRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  // Simulate loading data (replace with actual API call)
  Future<void> loadDummyData() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    fundRequests.value = List.generate(500, (index) {
      // Randomize some statuses for demo purposes
      String status = "PENDING";
      if (index % 5 == 0) status = "APPROVED";
      if (index % 7 == 0) status = "REJECTED";

      return {
        "username":
            index % 3 == 0 ? "VIP_User_${index + 1}" : "user_${index + 1}",
        "points": (index + 1) * 10,
        "method": index % 2 == 0 ? "UPI" : "Bank Transfer",
        "date": DateTime.now().subtract(Duration(days: index % 30)).toString(),
        "status": status,
        "id": index + 1,
        "transactionId": "TXN${DateTime.now().millisecondsSinceEpoch + index}",
      };
    });

    isLoading(false);
  }

  // Get filtered and paginated data
  List<Map<String, dynamic>> get paginatedData {
    var filteredData = fundRequests.where((request) {
      // Filter by search text
      final matchesSearch = request["username"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()) ||
          request["transactionId"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase());

      // Filter by status
      final matchesStatus = selectedStatus.value == "ALL" ||
          request["status"] == selectedStatus.value;

      return matchesSearch && matchesStatus;
    }).toList();

    // Apply pagination
    final start = (currentPage.value - 1) * rowsPerPage.value;
    final end = start + rowsPerPage.value;
    return filteredData.skip(start).take(rowsPerPage.value).toList();
  }

  // Get total pages for current filter
  int get totalPages {
    final filteredCount = fundRequests.where((request) {
      final matchesSearch = request["username"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase()) ||
          request["transactionId"]
              .toString()
              .toLowerCase()
              .contains(searchText.value.toLowerCase());

      final matchesStatus = selectedStatus.value == "ALL" ||
          request["status"] == selectedStatus.value;

      return matchesSearch && matchesStatus;
    }).length;

    return (filteredCount / rowsPerPage.value).ceil();
  }

  // Navigation methods
  void nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  // Action methods
  Future<void> approveRequest(int id) async {
    isLoading(true);
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final index = fundRequests.indexWhere((req) => req["id"] == id);
      if (index != -1) {
        fundRequests[index]["status"] = "APPROVED";
        fundRequests.refresh();
        Get.snackbar(
          "Success",
          "Request #$id approved",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> rejectRequest(int id) async {
    isLoading(true);
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final index = fundRequests.indexWhere((req) => req["id"] == id);
      if (index != -1) {
        fundRequests[index]["status"] = "REJECTED";
        fundRequests.refresh();
        Get.snackbar(
          "Success",
          "Request #$id rejected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading(false);
    }
  }

  // Reset filters
  void resetFilters() {
    searchText.value = '';
    selectedStatus.value = "ALL";
    currentPage.value = 1;
  }
}
