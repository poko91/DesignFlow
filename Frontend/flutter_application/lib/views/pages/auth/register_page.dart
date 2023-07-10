import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/auth/auth_api.dart';
import 'package:flutter_application/views/components/my_buttons.dart';
import 'package:flutter_application/views/components/my_textfield.dart';
import 'package:flutter_application/views/components/snackbar_helper.dart';
import 'package:flutter_application/views/components/text_gestureDectector.dart';
import 'package:flutter_application/views/components/text_tagline.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/pages/auth/login_page.dart';
import 'package:flutter_application/views/pages/profile/dashboard_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text editing controllers
  final studioNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future register() async {
    // Showing CircularProgressIndicator.
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade700),
          ),
        );
      },
    );

    // Getting value from Controller
    String studioName = studioNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    final response = await AuthService.register(studioName, email, password);
    var resBody = json.decode(response.body);

    if (response.statusCode == 201) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();

      // Save tokens in SharedPreferences
      var accessToken = resBody["access_token"];
      var refreshToken = resBody["refresh_token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', accessToken);
      prefs.setString('refresh_token', refreshToken);

      // Navigate to HomePage
      Get.to(() => const Dashboard());
    } else if (response.statusCode == 400) {
      // Hiding the CircularProgressIndicator.
       if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'Invalid Data');
    } else if (response.statusCode == 409) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'User already exists');
    } else {
      Get.back();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'An error occurred. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Welcome
                  const TitleText(title: 'Register'),
                  SizedBox(height: 25.h),
                  // Studio name textfield
                  MyTextField(
                    controller: studioNameController,
                    hintText: 'Studio name',
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  // Email address textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email address',
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  // Password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 50.h),
                  // login button
                  MyButton(
                    name: 'Register',
                    onTap: () {
                      register();
                    },
                  ),
                  SizedBox(height: 10.h),
                  // google button
                  MyButton(
                    name: "Sign up with Google",
                    onTap: () {
                      
                    }
                  ),
                  SizedBox(height: 50.h),
                  // Already have an account? Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TaglineText(tagline: 'Already have an account?'),
                      SizedBox(width: 20.w),
                      GestureDetectorText(
                        title: 'Sign in',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
