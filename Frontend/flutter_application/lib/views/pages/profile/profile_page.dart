import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/auth/auth_api.dart';
import 'package:flutter_application/api/users/change_password_api.dart';
import 'package:flutter_application/api/users/delete_account_api.dart';
import 'package:flutter_application/api/users/edit_studioName_api.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/api/users/users_api.dart';
import 'package:flutter_application/views/components/my_dialog_button.dart';
import 'package:flutter_application/views/components/my_dialog_textfield.dart';
import 'package:flutter_application/views/components/snackbar_helper.dart';
import 'package:flutter_application/views/components/text_tagline.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/components/text_title_sec.dart';
import 'package:flutter_application/views/pages/auth/login_page.dart';
import 'package:flutter_application/views/pages/profile/dashboard_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // text controller
  final studioNameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  User user = const User(email: '', studioName: 'Studio Name');

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future initUser() async {
    final user = await UserApi.getUser();

    setState(() => this.user = user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Row(children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              const TitleText(title: "Profile"),
              const Spacer(),
              IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.indigo[600],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Studio name
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            user.studioName,
                            style: TextStyle(
                                fontSize: 20, color: Colors.indigo[700]),
                          ),
                          IconButton(
                            onPressed: () {
                              openDialog();
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.indigo[600],
                            iconSize: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                  // email address
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.email,
                        style: GoogleFonts.comfortaa(
                          color: Colors.indigo[900],
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  // Account
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Account',
                            style: GoogleFonts.comfortaa(
                              color: Colors.indigo[900],
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Change password
                      Row(
                        children: [
                          const Icon(Icons.change_circle),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: openPasswordDialog,
                            child: Text(
                              'Change password',
                              style: GoogleFonts.comfortaa(
                                color: Colors.indigo[900],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.delete),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: openDeleteAccountDialog,
                            child: Text(
                              'Delete Account',
                              style: GoogleFonts.comfortaa(
                                color: Colors.indigo[900],
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Once you delete your account, you can no longer access your projects.',
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Studio Name
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const TitleText2(title: 'Studio Name'),
          content: MyDialogTextField(
            autofocus: true,
            controller: studioNameController,
            hintText: 'Enter Studio Name',
          ),
          actions: [
            MyDialogButton(
                name: 'Submit',
                onTap: () {
                  setState(() {
                    changeStudioName();
                  });
                  Get.back();
                }),
            MyDialogButton(
              name: 'Cancel',
              onTap: () => Get.back(),
            )
          ],
        ),
      );

  Future changeStudioName() async {
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

    final response = await StudioNameApi.changePassword(studioName);
    if (response.statusCode == 200) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        showSnackBar(context, message: 'Studio name changed successfully');
      } else {
        // Hiding the CircularProgressIndicator.
        if (context.mounted) Navigator.of(context).pop();
        if (context.mounted) {
          showSnackBar(context, message: 'Something went wrong');
        }
      }
    }
  }

  // Change password
  void openPasswordDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const TitleText2(title: 'Change Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyDialogTextField(
                  autofocus: true,
                  controller: oldPasswordController,
                  hintText: 'Enter current password',
                ),
                const SizedBox(height: 10),
                MyDialogTextField(
                  autofocus: true,
                  controller: passwordController,
                  hintText: 'Enter new password',
                ),
              ],
            ),
          ),
          actions: [
            MyDialogButton(name: 'Submit', onTap: changePassword),
            MyDialogButton(name: 'Cancel', onTap: () => Get.back()),
          ],
        ),
      );

  Future changePassword() async {
    // Getting value from Controller
    String oldPassword = oldPasswordController.text;
    String password = passwordController.text;

    final response = await PasswordApi.changePassword(oldPassword, password);
    if (response.statusCode == 200) {
      if (context.mounted) {
        showSnackBar(context, message: 'Password changed successfully');
        Timer(const Duration(seconds: 1), ()=> Get.to(() => const LoginPage()));
      }
    } else {
      if (context.mounted) {
        showSnackBar(context, message: 'Something went wrong');
      }
    }
  }

  // Delete account
  void openDeleteAccountDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[100],
          title: const TitleText2(title: 'Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TaglineText(
                  tagline: 'Are you sure you want to delete your account?',
                ),
              ],
            ),
          ),
          actions: [
            MyDialogButton(name: 'Delete', onTap: deleteAccount),
            MyDialogButton(
              name: 'Cancel',
              onTap: () => Get.back(),
            )
          ],
        ),
      );

  Future deleteAccount() async {
    final response = await DeleteAccountApi.deleteAccount();
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      () => Get.to(() => const Dashboard());
    } else {
      if (context.mounted) {
        showSnackBar(context, message: 'Something went wrong');
      }
    }
  }

  // Logout method
  Future logout() async {
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await AuthService.logout(prefs.getString('refresh_token'));

    if (response.statusCode == 204) {
      // Hiding the CircularProgressIndicator.
      Navigator.of(context).pop();

      // Delete sharedPref
      await prefs.clear();

      if (context.mounted) {
        showSnackBar(context, message: 'Logged out successfully');
      }

      () => Get.to(() => const LoginPage());
    } else {
      // Hiding the CircularProgressIndicator.
      ()=> Get.back();

      if (context.mounted) {
        showSnackBar(context,
            message: 'An error occurred.Please try again later.');
      }
    }
  }
}
