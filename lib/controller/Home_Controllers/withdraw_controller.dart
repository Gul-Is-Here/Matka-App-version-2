import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtka_app_version2/constants/user.dart';

class WithdrawalsController extends GetxController {
  final RxInt entriesPerPage = 10.obs;
  final RxInt currentPage = 1.obs;
  final RxString searchQuery = ''.obs;
  
  List<Map<String, dynamic>> get filteredRequests {
    if (searchQuery.isEmpty) return withdrawRequests;
    return withdrawRequests.where((request) {
      return request['username'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          request['mobile'].toString().contains(searchQuery) ||
          request['amount'].toString().contains(searchQuery);
    }).toList();
  }
}

