import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovillage/pages/login%20pages/login_page.dart';
import 'package:innovillage/theme.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final homeadd = TextEditingController();
  final password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> register_page() async {
    try {
      if (nama.text.isNotEmpty &&
          email.text.isNotEmpty &&
          phone.text.isNotEmpty &&
          homeadd.text.isNotEmpty &&
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
            "homeadd": homeadd.text,
            "uid": uid,
            "createdAt": FieldValue.serverTimestamp(),
          });

          // Navigate to the HomePages after successful registration
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginPages(),
          ));
        }
      } else {
        print("Error: All fields must be filled");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All fields must be filled.'),
          ),
        );
      }
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

  //

  bool _secureText = true;

  // void RegisterButtonPressed() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) =>
  //             LoginPages()), // Ganti NextPage() dengan halaman selanjutnya yang diinginkan
  //   );
  // }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "HALO MAMA",
                    style: regulerTextStyle.copyWith(
                        fontSize: 35, color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'REGISTER',
                  style: regulerTextStyle.copyWith(
                      fontSize: 25, color: Colors.blue),
                ),
                Text(
                  'Register New Your Account',
                  style: regulerTextStyle.copyWith(
                      fontSize: 15, color: Colors.blue),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 172, 170, 164),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: nama,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        hintStyle: regulerTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 172, 170, 164),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                        hintStyle: regulerTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 172, 170, 164),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone',
                        hintStyle: regulerTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 172, 170, 164),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: homeadd,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Home Address',
                        hintStyle: regulerTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 172, 170, 164),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        )
                      ],
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: password,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: regulerTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        await register_page();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPages()));
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
                        'Daftar',
                        style: regulerTextStyle.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
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
                      MaterialPageRoute(builder: (context) => LoginPages()),
                      (route) => false);
                },
                child: Text(
                  ' Login Now',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
