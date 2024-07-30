import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovillage/pages/login/login_bidan.dart';
import 'package:innovillage/theme.dart';

class RegisterBidan extends StatefulWidget {
  const RegisterBidan({super.key});

  @override
  State<RegisterBidan> createState() => _RegisterBidanState();
}

class _RegisterBidanState extends State<RegisterBidan> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerPage() async {
    try {
      if (nama.text.isNotEmpty &&
          email.text.isNotEmpty &&
          phone.text.isNotEmpty &&
          password.text.isNotEmpty) {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        if (userCredential.user != null) {
          String? uid = userCredential.user?.uid;

          await firestore.collection("user").doc(uid).set({
            "nama": nama.text,
            "email": email.text,
            "password": password.text,
            "phone": phone.text,
            "role": "bidan",
            "uid": uid,
            "createdAt": FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Akun berhasil dibuat! Silakan Log in.'),
            ),
          );

          // Navigate to the LoginBidan after successful registration
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginBidan(),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Semua kolom harus diisi.'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Alamat email sudah digunakan oleh akun lain.';
          break;
        case 'weak-password':
          errorMessage = 'Kata sandi yang diberikan terlalu lemah.';
          break;
        case 'invalid-email':
          errorMessage = 'Alamat email tidak valid.';
          break;
        default:
          errorMessage =
              'Terjadi kesalahan saat pendaftaran. Silakan coba lagi.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('An error occurred during registration. Please try again.'),
        ),
      );
    }
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(screenWidth * 0.06),
          children: [
            SizedBox(height: screenHeight * 0.06),
            Text(
              "Daftar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: screenWidth * 0.12,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Lengkapi Data Bidan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            _buildTextField(
              controller: nama,
              hintText: 'Nama',
              svgIcon: 'assets/icons/profile.svg',
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: phone,
              hintText: 'Nomor Telepon',
              svgIcon: 'assets/icons/phone.svg',
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: email,
              hintText: 'Email',
              svgIcon: 'assets/icons/mail.svg',
              screenWidth: screenWidth,
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildTextField(
              controller: password,
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
                  await registerPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFFF899E), // Button color
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  minimumSize: Size(screenWidth, screenHeight * 0.07),
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
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
                    'Sudah punya akun? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginBidan()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      ' Log In Disini',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04,
                        color: const Color(0XFFFF899E),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
