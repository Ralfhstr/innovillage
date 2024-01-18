import 'package:flutter/material.dart';
import 'package:innovillage/pages/home_pages.dart';
import 'package:innovillage/pages/tambah_ibu_hamil.dart';

class IbuHamil extends StatefulWidget {
  const IbuHamil({Key? key});

  @override
  State<IbuHamil> createState() => _IbuHamilState();
}

class _IbuHamilState extends State<IbuHamil> {
  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF427D9D),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePages()),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
              height: height * 0.07,
              width: width,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Adjust the percentage based on your layout
                  decoration: BoxDecoration(
                    color: Color(0xFF427D9D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height *
                      0.13, // Adjust the percentage based on your layout
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registrasi Ibu Hamil',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.07, // Adjust the percentage based on your layout
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Kecamatan Kalipare',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.035, // Adjust the percentage based on your layout
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahIbuHamil(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff9BBEC8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: height * 0.08,
                  width: width,
                  child: Center(
                    child: Text(
                      'Tambah Ibu Hamil',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF427D9D),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.50,
                width: width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
