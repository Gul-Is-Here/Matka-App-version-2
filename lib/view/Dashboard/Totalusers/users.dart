import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/TotalUser/userTabListWidget.dart'
    show buildUserListTab;
import '../../../widgets/TotalUser/userTabSourceListWidget.dart'
    show buildSourceListTab;

class TotalUsersScreen extends StatelessWidget {
  const TotalUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Management',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF1A237E),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            tabs: [
              Tab(child: Text('User List', style: GoogleFonts.poppins())),
              Tab(child: Text('Source List', style: GoogleFonts.poppins())),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A237E).withOpacity(0.05),
                const Color(0xFF283593).withOpacity(0.02),
              ],
            ),
          ),
          child: TabBarView(
            children: [
              buildUserListTab(),
              buildSourceListTab(),
            ],
          ),
        ),
      ),
    );
  }
}

