import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/admin/ibu_hamil.dart';
import 'package:innovillage/pages/admin/profil_ibu_hamil.dart';
import 'package:innovillage/pages/role.dart';
import 'package:innovillage/pages/video/lainnya.dart';
import 'package:innovillage/pages/rekam%20medis%20ibu%20hamil/menu_kehamilan.dart';
import 'package:innovillage/pages/admin/pelayanan_dokter.dart';

class AdminHomePages extends StatefulWidget {
  const AdminHomePages({Key? key});

  @override
  State<AdminHomePages> createState() => _AdminHomePagesState();
}

class _AdminHomePagesState extends State<AdminHomePages> {
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Role()), // Ganti dengan halaman login yang sesuai
        (route) => false,
      );
    } catch (e) {
      print("Error during logout: $e");
      // Handle error during logout
      // Misalnya, tampilkan pesan kesalahan
    }
  }

  late double height, width;

  List imgData = [
    "assets/hamil.png",
    "assets/jadwal.png",
    "assets/grafik.png",
    "assets/lainnya.png",
  ];

  List titles = [
    "Registrasi Ibu",
    "Cek Kesehatan",
    "Catatan",
    "Video",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF427D9D),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                logout();
                // Handle logout action here
                // For example, you can navigate to the login screen
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: GestureDetector(
                  onTap: () async {
                    logout();
                    // Sign out the user
                    // await FirebaseAuth.instance.signOut();

                    // // Navigate to the login screen
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Role()),
                    //   (route) => false,
                    // );
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
        title: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "HALO MAMA - Bidan",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            height = constraints.maxHeight;
            width = constraints.maxWidth;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: Color(0xFF427D9D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: width > height ? width * 0.15 : height * 0.15,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bidan',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '1234',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Color(0xFF427D9D),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: height * 0.47,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width > height ? 4 : 2,
                          childAspectRatio: 1.1,
                          mainAxisSpacing: width * 0.05,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: imgData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigateToScreen(titles[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff9BBEC8),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    imgData[index],
                                    width: 50,
                                  ),
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void navigateToScreen(String title) {
    if (title == "Registrasi Ibu") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IbuHamil()),
        (route) => false,
      );
    } else if (title == "Kesehatan") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MenuKehamilan()),
        (route) => false,
      );
    } else if (title == "Catatan") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PelayananDokter()),
        (route) => false,
      );
    } else if (title == "Video") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FilePickerDemo()),
        (route) => false,
      );
    }
  }
}
