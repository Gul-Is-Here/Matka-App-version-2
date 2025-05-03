import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel {
  final String name;
  final String mobile;
  final String lastSeen;
  final int balance;
  final String transfer;
  final String active;
  final String status;

  UserModel({
    required this.name,
    required this.mobile,
    required this.lastSeen,
    required this.balance,
    required this.transfer,
    required this.active,
    required this.status,
  });
}

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var currentPage = 1.obs;
  var entriesPerPage = 10;
  var isLoading = false.obs;
  var searchText = ''.obs;
  var transferFilter = 'All'.obs;
  var statusFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    isLoading.value = true;
    final dummy = List.generate(100, (i) => UserModel(
      name: 'User $i',
      mobile: '98000000$i',
      lastSeen: 'Apr 15, 2025 - 10:00 AM',
      balance: 50,
      transfer: i % 2 == 0 ? 'Yes' : 'No',
      active: i % 3 == 0 ? 'Active' : 'Inactive',
      status: i % 4 == 0 ? 'Verified' : 'Not Verified',
    ));
    users.assignAll(dummy);
    applyFilters();
    isLoading.value = false;
  }

  void applyFilters() {
    final filtered = users.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(searchText.value.toLowerCase());
      final matchesTransfer = transferFilter.value == 'All' || user.transfer == transferFilter.value;
      final matchesStatus = statusFilter.value == 'All' || user.status == statusFilter.value;
      return matchesSearch && matchesTransfer && matchesStatus;
    }).toList();
    filteredUsers.assignAll(filtered);
  }

  List<UserModel> get paginatedUsers {
    final start = (currentPage.value - 1) * entriesPerPage;
    final end = start + entriesPerPage;
    return filteredUsers.sublist(start, end > filteredUsers.length ? filteredUsers.length : end);
  }

  void nextPage() {
    if ((currentPage.value * entriesPerPage) < filteredUsers.length) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }
}