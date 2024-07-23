import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovillage/pages/login%20pages/login_page.dart';
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
            SnackBar(
              content: Text('Akun berhasil dibuat! Silakan Log in.'),
            ),
          );

          // Navigate to the LoginPages after successful registration
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginPages(),
          ));
        }
      } else {
        print("Error: All fields must be filled");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
      print("Error during registration: $e");
    } catch (e) {
      print("Error during registration: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SizedBox(height: 80),
            Text(
              "Daftar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 48,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Lengkapi Data Mama",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            _buildTextField(
              controller: nama,
              hintText: 'Nama',
              svgIcon: 'assets/icons/profile.svg',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: phone,
              hintText: 'Nomor Telepon',
              svgIcon: 'assets/icons/phone.svg',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: email,
              hintText: 'Email',
              svgIcon: 'assets/icons/mail.svg',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: password,
              hintText: 'Password',
              svgIcon: 'assets/icons/key.svg',
              obscureText: _secureText,
              // suffixIcon: IconButton(
              //   onPressed: showHide,
              //   icon: _secureText
              //       ? Icon(Icons.visibility_off, size: 20)
              //       : Icon(Icons.visibility, size: 20),
              // ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await registerPage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFFF899E), // Button color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPages()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      ' Log In Disini',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
