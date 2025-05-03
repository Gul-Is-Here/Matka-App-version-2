import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtka_app_version2/controller/Menu/MainMarket/mainMarketController.dart';
import 'package:mtka_app_version2/view/Menu/BrandSetting/brandSettngsScreen.dart';
import 'package:mtka_app_version2/view/Menu/MainMarket/galiDesawerScreen.dart';
import 'package:mtka_app_version2/view/Menu/MainMarket/starlineScreen.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/CustomerSellReportScreen.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/autoDepositScreen.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/bidWinnigReportScreen.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/transferPointReport.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/userBidHistory.dart';
import 'package:mtka_app_version2/view/Menu/ReportManagement/winningReportScreen.dart';
import 'package:mtka_app_version2/view/Menu/VipSection/vipSectionScreen.dart';
import 'package:mtka_app_version2/view/Menu/walletManagement/bidRevertScreen.dart';
import 'package:mtka_app_version2/view/Menu/walletManagement/fundBonusScreen.dart';
import 'package:mtka_app_version2/view/Menu/walletManagement/fundRequestListScreen.dart';
import 'package:mtka_app_version2/view/Menu/walletManagement/withdrawFundListScreen.dart';
import 'package:mtka_app_version2/view/Menu/walletManagement/withdrawRequestListScreen.dart';
import 'view/Menu/ReportManagement/addFundReportScreen.dart';
import 'view/Menu/ReportManagement/withdrawReportScreen.dart';
import 'view/Menu/UserDetails/userDetailsScreen.dart' show UserDetailsScreen;
import 'view/Menu/AppSettings/appSettingsScreen.dart';
import 'view/Auth/login.dart';
import 'view/Dashboard/Home.dart';
import 'view/Auth/splash_screen.dart';
import 'view/Menu/MainMarket/mainMarketScreen.dart';
import 'view/Menu/PaymentSettings/paymentSettingsScreen.dart'
    show PaymentConfigScreen, PaymentConfigurationScreen;
import 'view/Menu/walletManagement/addFundListScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalyan Online Matka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/Home': (context) => const AdminDashboard(),
        '/app-setting': (context) => SettingsScreen(),
        '/payment-setting': (context) => PaymentConfigScreen(),
        '/more-setting': (context) => BrandSettingsScreen(),
        '/main-markets': (context) => const MainMarketsScreen(),
        '/starline': (context) => const StarlineScreen(),
        '/gali-disawar': (context) => const GaliDisawarScreen(),
        '/vip-section': (context) => const VipSectionScreen(),
        '/user-details': (context) => const UserDetailsScreen(),
        '/user-bid-history': (context) => BidHistoryScreen(),
        '/customer-sell-report': (context) => CustomerSellReportScreen(),
        '/winning-report': (context) => WinningReportScreen(),
        '/transfer-point-report': (context) => TransferPointReportScreen(),
        '/bid-winning-report': (context) => BidWinningReportScreen(),
        '/withdraw-report': (context) => WithdrawReportScreen(),
        '/add-fund-report': (context) => AddFundReportScreen(),
        '/auto-deposit-history': (context) => AutoDepositScreen(),
        '/fund-request-list': (context) => FundRequestListScreen(),
        '/withdraw-request-list': (context) => WithdrawRequestListScreen(),
        '/withdraw-fund': (context) => WithdrawFundListScreen(),
        '/add-fund': (context) => AddFundListScreen(),
        '/fund-bonus': (context) => FundBonusScreen(),
        '/bid-revert': (context) => BidRevertScreen()
      },
    );
  }
}
