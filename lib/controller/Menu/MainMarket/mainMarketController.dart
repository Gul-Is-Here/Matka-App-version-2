// controllers/market_controller.dart
import 'package:get/get.dart';

class MarketController extends GetxController {
  // Databoard items
  var databoardItems = [
    'App Setting',
    'Payment Setting',
    'More Settings',
    'Markets',
    'Vip Section',
    'User Details',
    'Report Management',
    'Wallet Management',
    'Notice Management',
    'Web Setting',
    'Admin & Roles Modules',
    'Declare Result',
  ].obs;

  // Game Type items
  var gameTypeItems = [
    'Declare Result',
    'Announced Result',
  ].obs;

  // Bazaar items
  var bazaarItems = [
    'Akii Bazaar',
    'Bazaar List',
    'Bazaar Time',
  ].obs;

  // All Reports items
  var reportItems = [
    'Single Digit',
    'Jodi Digit',
    'Single Panna',
    'Double Panna',
    'Triple Panna',
    'Half Sangam',
    'Full Sangam',
  ].obs;

  // Winning List items
  var winningItems = [
    'Single Digit',
    'Jodi Digit',
    'Single Panna',
    'Double Panna',
    'Triple Panna',
    'Half Sangam',
    'Full Sangam',
  ].obs;
}