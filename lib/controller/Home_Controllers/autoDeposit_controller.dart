
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundRequestController extends GetxController {
  final RxInt entriesPerPage = 10.obs;
  final RxInt currentPage = 1.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'ALL'.obs;
  
  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> fundRequests = [
    {
      'username': 'jhon show',
      'points': 1000,
      'method': 'UPI IP',
      'date': '12-04-2025 10:45:49 pm',
      'status': 'PENDING',
    },
    {
      'username': 'jhon show',
      'points': 500,
      'method': 'Bank Deposit',
      'date': '02-04-2025 01:44:41 am',
      'status': 'APPROVED',
    },
    {
      'username': 'jhon show',
      'points': 500,
      'method': 'QR Deposit',
      'date': '02-04-2025 01:43:48 am',
      'status': 'REJECTED',
    },
    {
      'username': 'jhon show',
      'points': 4294867295,
      'method': 'Bank Deposit',
      'date': '30-03-2025 10:14:34 pm',
      'status': 'PENDING',
    },
    {
      'username': 'jhon show',
      'points': 4294867295,
      'method': 'Bank Deposit',
      'date': '30-03-2025 10:14:19 pm',
      'status': 'PENDING',
    },
    {
      'username': 'jhon show',
      'points': 500,
      'method': 'QR Deposit',
      'date': '30-03-2025 10:10:46 pm',
      'status': 'PENDING',
    },
    {
      'username': 'VIP User',
      'points': 500,
      'method': 'UPI IP',
      'date': '29-03-2025 11:33:48 am',
      'status': 'PENDING',
    },
    {
      'username': 'VIP User',
      'points': 2000,
      'method': 'UPI IP',
      'date': '29-03-2025 11:33:17 am',
      'status': 'PENDING',
    },
    {
      'username': 'jhon show',
      'points': 500,
      'method': 'Bank Deposit',
      'date': '26-03-2025 08:09:19 pm',
      'status': 'PENDING',
    },
    {
      'username': 'VIP User',
      'points': 2,
      'method': 'QR Deposit',
      'date': '26-03-2025 08:06:54 pm',
      'status': 'PENDING',
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    var results = fundRequests.where((request) {
      final matchesSearch = searchQuery.isEmpty ||
          request['username'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          request['method'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus.value == 'ALL' || 
          request['status'].toString() == selectedStatus.value;
      
      return matchesSearch && matchesStatus;
    }).toList();
    
    return results;
  }

  List<Map<String, dynamic>> get paginatedRequests {
    final start = (currentPage.value - 1) * entriesPerPage.value;
    final end = start + entriesPerPage.value;
    return filteredRequests.sublist(
      start.clamp(0, filteredRequests.length),
      end.clamp(0, filteredRequests.length),
    );
  }

  void approveRequest(int index) {
    fundRequests[index]['status'] = 'APPROVED';
    update();
    Get.snackbar(
      'Approved',
      'Request has been approved',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void rejectRequest(int index) {
    fundRequests[index]['status'] = 'REJECTED';
    update();
    Get.snackbar(
      'Rejected',
      'Request has been rejected',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}