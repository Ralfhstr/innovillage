import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innovillage/pages/home/home_pages.dart';
import 'package:innovillage/pages/home/home_mama.dart';
import 'package:innovillage/pages/register/register_bidan.dart';
import 'package:innovillage/pages/register/register_mama.dart';
import 'package:innovillage/theme.dart';

class LoginMama extends StatefulWidget {
  const LoginMama({Key? key}) : super(key: key);

  @override
  State<LoginMama> createState() => _LoginMamaState();
}

class _LoginMamaState extends State<LoginMama> {
  bool _secureText = true;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final emailC = TextEditingController();
  final passC = TextEditingController();

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    if (userDoc.exists) {
      return userDoc['role'];
    }
    return null;
  }

  Future<void> login() async {
    try {
      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailC.text, password: passC.text);

        if (userCredential.user != null) {
          String? role = await getUserRole(userCredential.user!.uid);
          if (role == 'bidan') {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePages(),
            ));
          } else if (role == 'mama') {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeMama(),
            ));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginMama(),
            ));
          }
        }
      } else {
        showCenteredFlushbar(
          'Email dan password harus diisi.',
          context,
          isError: true,
        );
      }
    } catch (e) {
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
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
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
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(screenWidth * 0.06),
            children: [
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Image.asset(
                  "assets/images/logo.png", // Replace with the path to your logo image
                  height: screenWidth * 0.25,
                  width: screenWidth * 0.25,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Text(
                  "HALO MAMA",
                  style: regulerTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: screenWidth * 0.09,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Masuk ke Akun Anda',
                  style: regulerTextStyle.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildTextField(
                controller: emailC,
                hintText: 'Email',
                svgIcon: 'assets/icons/mail.svg',
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTextField(
                controller: passC,
                hintText: 'Password',
                svgIcon: 'assets/icons/key.svg',
                obscureText: _secureText,
                screenWidth: screenWidth,
                suffixIcon: IconButton(
                  onPressed: showHide,
                  icon: _secureText
                      ? Icon(Icons.visibility_off, size: screenWidth * 0.05)
                      : Icon(Icons.visibility, size: screenWidth * 0.05),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFFF899E),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    minimumSize: Size(screenWidth, screenHeight * 0.07),
                  ),
                  child: Text(
                    'Login',
                    style: regulerTextStyle.copyWith(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
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
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterMama(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        ' Daftar Disini',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: const Color(0XFFFF899E),
                          fontSize: screenWidth * 0.04,
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
    required double screenWidth,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      height: screenWidth * 0.125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
      width: screenWidth,
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
              child: SvgPicture.asset(
                svgIcon,
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: screenWidth * 0.1,
              minHeight: screenWidth * 0.1,
            ),
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: regulerTextStyle.copyWith(
              fontSize: screenWidth * 0.04,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
