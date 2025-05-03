import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/auth_widgets/textFieldWidget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF110124), // Deep blue
              Color(0xFF283593), // Slightly lighter blue
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                // Image.asset(
                //   'assets/logonobg.png',
                //   width: MediaQuery.of(context).size.width * 0.5,
                // )
                //     .animate()
                //     .scale(duration: 800.ms)
                //     .then(delay: 200.ms)
                //     .shake(),

                const SizedBox(height: 30),

                // App Title with Animation
                Text(
                  'Kalyan Online Matka',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),

                const SizedBox(height: 8),

                // SM Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'SM',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                const SizedBox(height: 40),

                // Username Field
                buildTextField(
                  context,
                  label: 'Username, Email or Mobile Number',
                  icon: Icons.person_outline,
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.3),

                const SizedBox(height: 20),

                // Password Field
                buildTextField(
                  context,
                  label: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.4),

                const SizedBox(height: 30),

                // Login Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Colors.amber, Color(0xffFAE86E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/Home');
                    },
                    child: Text(
                      'LOG IN',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.5),

                const SizedBox(height: 20),

                // Forgot Password
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      color: Color(0xffFAE86E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
