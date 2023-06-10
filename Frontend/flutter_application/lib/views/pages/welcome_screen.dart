import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/views/components/text_tagline.dart';
import 'package:flutter_application/views/pages/auth/login_page.dart';
import 'package:flutter_application/views/pages/profile/dashboard_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _accessToken;
  String? _refreshToken;

  Future<bool> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
    // print(access_token);
    // print(refresh_token);
    if (_accessToken != null) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    // getTokens();
    Timer(const Duration(seconds: 4), () {
      navigate();
    });
  }

  navigate() async {
    var checkLogin = getTokens();
    if (checkLogin == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            children: [

              const SizedBox(height: 115),

              // App name
              Text(
                'DesignFlow',
                style: GoogleFonts.comfortaa(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[800],
                ),
              ),

              const SizedBox(height: 20),

              // Tagline
              TaglineText(tagline: 'Manage your project tasks hassel free.'),

              const SizedBox(height: 100),

              // Animation
              SizedBox(
                height: 250,
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_fUq9u8VGIo.json'),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
