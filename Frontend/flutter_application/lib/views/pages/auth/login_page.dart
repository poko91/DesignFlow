import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/auth/auth_api.dart';
import 'package:flutter_application/api/users/users_api.dart';
import 'package:flutter_application/views/components/my_buttons.dart';
import 'package:flutter_application/views/components/my_textfield.dart';
import 'package:flutter_application/views/components/snackbar_helper.dart';
import 'package:flutter_application/views/components/text_gestureDectector.dart';
import 'package:flutter_application/views/components/text_tagline.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/pages/auth/register_page.dart';
import 'package:flutter_application/views/pages/profile/dashboard_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login() async {
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
    String email = _emailController.text;
    String password = _passwordController.text;

    final response = await AuthService.login(email, password);
    var resBody = json.decode(response.body);

    if (response.statusCode == 200) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();

      // Save tokens in SharedPreferences
      var accessToken = resBody["access_token"];
      var refreshToken = resBody["refresh_token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', accessToken);
      prefs.setString('refresh_token', refreshToken);

      // get User details
      setState(() {
        UserApi.getUser();
      });

      Get.to(() => const Dashboard());
    } else if (response.statusCode == 400) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'Invalid Data');
    } else if (response.statusCode == 401) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) {
        showSnackBar(context, message: 'Invalid email or password');
      }
    } else {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) {
        showSnackBar(context,
            message: 'An error occurred. Please try again later.');
      }
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
                  const TitleText(title: 'Welcome'),
                  
                  SizedBox(height: 25.h),
                  
                  // Email textfield
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    obscureText: false,
                  ),
                  
                  SizedBox(height: 10.h),
                  
                  // password textfield
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  
                  SizedBox(height: 15.h),
                  
                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetectorText(
                        onTap: () {},
                        title: 'Forgot password?',
                      )
                    ],
                  ),
                  
                  SizedBox(height: 50.h),
                  
                  // login button
                  MyButton(
                    name: 'Login',
                    onTap: () {
                      login();
                    },
                  ),
                  
                  SizedBox(height: 10.h),
                  
                  // google button
                  MyButton(
                    name: "Sign in with Google",
                    onTap: () {
                      
                    },
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  // not a member? register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TaglineText(tagline: 'Not a member?'),
                      SizedBox(width: 20.w),
                      GestureDetectorText(
                        onTap: () {
                          Get.to(() => const RegisterPage());
                        },
                        title: 'Register now',
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
