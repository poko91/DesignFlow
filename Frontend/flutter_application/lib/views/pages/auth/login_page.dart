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
import 'package:google_sign_in/google_sign_in.dart';
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

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else if (response.statusCode == 400) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'Invalid Data');
    } else if (response.statusCode == 401) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'Invalid email or password');
    } else {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      // Show snackbar
      if (context.mounted) showSnackBar(context, message: 'An error occurred. Please try again later.');
    }
  }

  // Signin with google
  GoogleSignInAccount? _googleUser;

  Future<void> _signInGoogle() async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'profile',
      ],
    );
        /// if previously signed in, it will signin silently
        /// if not, the signin dialog/login page will pop up
    _googleUser =
        await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
  } catch (e) {
    debugPrint(e.toString());
  }
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
              // Welcome
              const TitleText(title: 'Welcome'),

              const SizedBox(height: 25),

              // Email textfield
              MyTextField(
                controller: _emailController,
                hintText: 'Email address',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 15),

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

              const SizedBox(height: 115),

              // login button
              MyButton(
                name: 'Login',
                onTap: () {
                  login();
                },
              ),

              const SizedBox(height: 20),

              // google button
              MyButton(
                name: "Sign in with Google",
                onTap: () {
                  _signInGoogle();
                },
              ),

              const SizedBox(height: 80),

              // not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TaglineText(tagline: 'Not a member?'),
                  const SizedBox(width: 20),
                  GestureDetectorText(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    title: 'Register now',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
