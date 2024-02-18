import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/admin/admin_page.dart';

import 'package:innovillage/pages/daftar%20pages/register_page.dart';
import 'package:innovillage/theme.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _secureText = true;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  void onLoginButtonPressed() {
    // Implement your login logic here
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>
    //           HomePages()), // Replace with the desired next page
    // );
  }

  final emailC = TextEditingController();
  final passC = TextEditingController();

  Future<void> login() async {
    try {
      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          // Tidak ada pengecekan peran admin lagi di sini
          // Hanya navigasi ke halaman default setelah login berhasil
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                const AdminHomePages(), // Adjust with your default home page
          ));
        }
      } else {
        print("Error: Email and password must be filled");
        showCenteredFlushbar(
          'Email dan password harus diisi.',
          context,
          isError: true,
        );
      }
    } catch (e) {
      print("Error during login: $e");
      showCenteredFlushbar(
        'Terjadi kesalahan saat login. Silakan coba lagi.',
        context,
        isError: true,
      );
    }
  }

  // Function to show centered Flushbar
  void showCenteredFlushbar(String message, BuildContext context,
      {bool isError = false}) {
    Flushbar(
      message: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      margin: EdgeInsets.all(8),
      // borderRadius:
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/logo.png", // Replace with the path to your logo image
                      height: 80, // Adjust the height as needed
                      width: 80, // Adjust the width as needed
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      "HALO MAMA",
                      style: regulerTextStyle.copyWith(
                        fontSize: 35,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'LOGIN',
                    style: regulerTextStyle.copyWith(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Login Into Your Account',
                    style: regulerTextStyle.copyWith(
                        fontSize: 15, color: Colors.blue),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: emailC,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                        hintStyle: regulerTextStyle.copyWith(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      obscureText: _secureText,
                      controller: passC,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: regulerTextStyle.copyWith(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await login();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: regulerTextStyle.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPages(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          ' Create Account',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
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
}
