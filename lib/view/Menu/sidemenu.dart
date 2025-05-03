import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final Map<String, List<String>> _menuItems = {
    'Dashboard': [],
    'App Setting': [],
    'Payment Setting': [],
    'More Setting': [],
    'Markets': ['Main Markets', 'Starline', 'Gali Disawar'],
    'Vip Section': [],
    'User Details': [],
    'Report Management': [
      'User Bid History',
      'Customer Sell Report',
      'Winning Report',
      'Transfer Point Report',
      'Bid Winning Report',
      'Withdraw Report',
      'Add Fund Report',
      'Auto Deposit History'
    ],
    'Wallet Management': [
      'Fund Request List',
      'Withdraw Request List',
      'Withdraw Fund',
      'Add Fund',
      'Fund Bonus',
      'Bid Revert'
    ],
    'Notice Management': ['Notice List', 'Notice Add'],
    'Admin & Roles': ['Admin Group Roles', 'Admin List', 'Admin Add'],
    'Web Setting': [],
  };

  int? _expandedIndex;
  bool _isMenuExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _isMenuExpanded ? 280 : 72,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_isMenuExpanded)
                  Text(
                    'Admin Panel',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    _isMenuExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      setState(() => _isMenuExpanded = !_isMenuExpanded),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 16),
                ..._menuItems.entries.map((entry) {
                  final index = _menuItems.keys.toList().indexOf(entry.key);
                  final isExpanded = _expandedIndex == index;
                  return _buildMenuTile(
                    title: entry.key,
                    children: entry.value,
                    isExpanded: isExpanded,
                    onTap: () {
                      if (entry.value.isEmpty) {
                        _navigateToScreen(entry.key);
                      } else {
                        setState(() {
                          _expandedIndex = isExpanded ? null : index;
                        });
                      }
                    },
                  );
                }),
                _buildDeclareResultSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(String screenName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }

    switch (screenName) {
      case 'Dashboard':
        Get.toNamed('/dashboard');
        break;
      case 'App Setting':
        Get.toNamed('/app-setting');
        break;
      case 'Payment Setting':
        Get.toNamed('/payment-setting');
        break;
      case 'More Setting':
        Get.toNamed('/more-setting');
        break;
      case 'Vip Section':
        Get.toNamed('/vip-section');
        break;
      case 'User Details':
        Get.toNamed('/user-details');
        break;
      case 'Web Setting':
        Get.toNamed('/web-setting');
        break;
      default:
        Get.toNamed('/under-construction',
            arguments: {'screenName': screenName});
    }
  }

  Widget _buildMenuTile({
    required String title,
    required List<String> children,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: _getIconForMenu(title),
          title: _isMenuExpanded
              ? Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                )
              : null,
          trailing: children.isNotEmpty && _isMenuExpanded
              ? RotatedBox(
                  quarterTurns: isExpanded ? 1 : 0,
                  child:
                      const Icon(Icons.arrow_drop_down, color: Colors.white70),
                )
              : null,
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(
            horizontal: _isMenuExpanded ? 16 : 0,
            vertical: 4,
          ),
          minLeadingWidth: 10,
          dense: true,
        ),

        // Child items
        if (isExpanded && _isMenuExpanded && children.isNotEmpty)
          ...children.map((child) {
            return Padding(
              padding: const EdgeInsets.only(left: 24),
              child: ListTile(
                leading: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.white54,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(
                  child,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                onTap: () {
                  if (title == 'Report Management') {
                    navigateToReportManagmentScreen(child);
                  } else if (title == 'Wallet Management') {
                    _navigateToWalletManagmentScreen(child);
                  } else {
                    _navigateToSubScreen(child);
                  }
                },
                contentPadding: const EdgeInsets.only(left: 32),
                minLeadingWidth: 10,
                dense: true,
              ),
            );
          }),

        Divider(
          height: 1,
          color: Colors.white.withOpacity(0.1),
          indent: _isMenuExpanded ? 16 : 0,
          endIndent: 16,
        ),
      ],
    );
  }

  void _navigateToSubScreen(String screenName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }

    switch (screenName) {
      case 'Main Markets':
        Get.toNamed('/main-markets');
        break;
      case 'Starline':
        Get.toNamed('/starline');
        break;
      case 'Gali Disawar':
        Get.toNamed('/gali-disawar');
        break;
      case 'Fund Request List':
        Get.toNamed('/fund-request-list');
        break;
      case 'Withdraw Request List':
        Get.toNamed('/withdraw-request-list');
        break;
      case 'Withdraw Fund':
        Get.toNamed('/withdraw-fund');
        break;
      case 'Add Fund':
        Get.toNamed('/add-fund');
        break;
      case 'Fund Bonus':
        Get.toNamed('/fund-bonus');
        break;
      case 'Bid Revert':
        Get.toNamed('/bid-revert');
        break;
      case 'Notice List':
        Get.toNamed('/notice-list');
        break;
      case 'Notice Add':
        Get.toNamed('/notice-add');
        break;
      case 'Admin Group Roles':
        Get.toNamed('/admin-group-roles');
        break;
      case 'Admin List':
        Get.toNamed('/admin-list');
        break;
      case 'Admin Add':
        Get.toNamed('/admin-add');
        break;
      default:
        Get.toNamed('/under-construction',
            arguments: {'screenName': screenName});
    }
  }

  void navigateToReportManagmentScreen(String screenName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }

    switch (screenName) {
      case 'User Bid History':
        Get.toNamed('/user-bid-history');
        break;
      case 'Customer Sell Report':
        Get.toNamed('/customer-sell-report');
        break;
      case 'Winning Report':
        Get.toNamed('/winning-report');
        break;
      case 'Transfer Point Report':
        Get.toNamed('/transfer-point-report');
        break;
      case 'Bid Winning Report':
        Get.toNamed('/bid-winning-report');
        break;
      case 'Withdraw Report':
        Get.toNamed('/withdraw-report');
        break;
      case 'Add Fund Report':
        Get.toNamed('/add-fund-report');
        break;
      case 'Auto Deposit History':
        Get.toNamed('/auto-deposit-history');
        break;
      default:
        Get.toNamed('/bid-revert', arguments: {'screenName': screenName});
    }
  }

  void _navigateToWalletManagmentScreen(String screenName) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }

    switch (screenName) {
      case 'Fund Request List':
        Get.toNamed('/fund-request-list');
        break;
      case 'Withdraw Request List':
        Get.toNamed('/withdraw-request-list');
        break;
      case 'Withdraw Fund':
        Get.toNamed('/withdraw-fund');
        break;
      case 'Add Fund':
        Get.toNamed('/add-fund');
        break;
      case 'Fund Bonus':
        Get.toNamed('/fund-bonus');
        break;
      default:
        Get.toNamed('/bid-revert',
            arguments: {'screenName': screenName});
    }
  }

  Widget _buildDeclareResultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Declare Result',
            style: GoogleFonts.poppins(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildSubMenuTile('Starline',
            onTap: () => _navigateToSubScreen('Starline')),
        _buildSubMenuTile('Gali Disawar',
            onTap: () => _navigateToSubScreen('Gali Disawar')),
      ],
    );
  }

  Widget _buildSubMenuTile(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: ListTile(
        leading: const Icon(Icons.arrow_right, size: 16, color: Colors.white54),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.8),
            fontSize: 13,
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 32),
        minLeadingWidth: 10,
        dense: true,
      ),
    );
  }

  Icon _getIconForMenu(String title) {
    switch (title) {
      case 'Dashboard':
        return const Icon(Icons.dashboard, color: Colors.white);
      case 'Report Management':
        return const Icon(Icons.assessment, color: Colors.white);
      case 'Wallet Management':
        return const Icon(Icons.account_balance_wallet, color: Colors.white);
      case 'Notice Management':
        return const Icon(Icons.notifications, color: Colors.white);
      case 'Admin & Roles':
        return const Icon(Icons.admin_panel_settings, color: Colors.white);
      case 'Markets':
        return const Icon(Icons.store, color: Colors.white);
      default:
        return const Icon(Icons.settings, color: Colors.white);
    }
  }
}
