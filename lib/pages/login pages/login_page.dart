import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innovillage/pages/admin/admin_page.dart';
import 'package:innovillage/pages/register/register_bidan.dart';
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

  final emailC = TextEditingController();
  final passC = TextEditingController();

  Future<void> login() async {
    try {
      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
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

  void showCenteredFlushbar(String message, BuildContext context,
      {bool isError = false}) {
    Flushbar(
      message: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      margin: EdgeInsets.all(8),
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
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SizedBox(height: 80),
              Center(
                child: Image.asset(
                  "assets/images/logo.png", // Replace with the path to your logo image
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "HALO MAMA",
                  style: regulerTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Masuk ke Akun Anda',
                  style: regulerTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              // Text(
              //   'Masuk ke Akun Anda',
              //   style: regulerTextStyle.copyWith(
              //       fontFamily: 'Poppins', fontSize: 15, color: Colors.black),
              // ),
              SizedBox(height: 20),
              _buildTextField(
                controller: emailC,
                hintText: 'Email',
                svgIcon: 'assets/icons/mail.svg',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: passC,
                hintText: 'Password',
                svgIcon: 'assets/icons/key.svg',
                obscureText: _secureText,
                // suffixIcon: IconButton(
                //   onPressed: showHide,
                //   icon: _secureText
                //       ? Icon(Icons.visibility_off, size: 20, color: Colors.grey)
                //       : Icon(Icons.visibility, size: 20, color: Colors.grey),
                // ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFFF899E),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
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
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterBidan(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        ' Dafar Disini',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFFF899E),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String svgIcon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(64, 172, 170, 164),
            offset: Offset(0, 1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: SvgPicture.asset(
                svgIcon,
                width: 24,
                height: 24,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: regulerTextStyle.copyWith(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
