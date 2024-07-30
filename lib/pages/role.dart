import 'package:flutter/material.dart';
import 'package:innovillage/pages/login/login_bidan.dart';
import 'package:innovillage/pages/login/login_mama.dart';

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  String? _selectedRole = 'Ibu Hamil';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    double fontSize(double percentage) {
      return screenWidth * percentage;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8F9),
        body: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: screenSize.width,
                margin: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.05),
                    Image.asset(
                      "assets/cover.png",
                      width: screenSize.width * 0.5,
                      height: screenSize.height * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.9,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      spreadRadius: 2.0,
                      blurRadius: 2.0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Jaga ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize(0.07),
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "kesehatan dan tumbuh kembang",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize(0.07),
                              color: const Color(0XFFFF899E),
                            ),
                          ),
                          TextSpan(
                            text: " bayi anda mulai dari sekarang",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: fontSize(0.07),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Bergabung bersama kami untuk mulai menjaga anak dalam kandungan. Gabung sebagai:",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: fontSize(0.04),
                        color: Colors.black,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedRole,
                        items:
                            <String>['Bidan', 'Ibu Hamil'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: fontSize(0.04))),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedRole = newValue;
                          });
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Color(0XFFFF899E),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedRole == 'Bidan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginBidan()),
                            );
                          } else if (_selectedRole == 'Ibu Hamil') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginMama()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFFF899E),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.015,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          textStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize(0.04),
                          ),
                        ),
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(color: Colors.white),
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
}
