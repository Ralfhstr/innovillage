import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMama extends StatelessWidget {
  const HomeMama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFF8F9),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.025,
          ),
          child: Column(
            children: [
              _buildMainContent(screenWidth, screenHeight),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHelloContent(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.03),
          _buildKondisiCard(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          _buildScheduleCheckupSection(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget _buildHelloContent(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: screenWidth * 0.1,
            width: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: const Color(0XFFD9D9D9),
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                Text(
                  "Mama Diana",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              "assets/icons/notification.svg",
              height: screenWidth * 0.06,
              width: screenWidth * 0.06,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKondisiCard(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kondisi Janin",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: const Color(0XFFFF899E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.02),
                    topRight: Radius.circular(screenWidth * 0.02),
                  ),
                ),
                child: Text(
                  "Trimester 3 : 21 Minggu, 3 Hari",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/height.svg",
                          height: screenWidth * 0.08,
                          width: screenWidth * 0.08,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "1 cm",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/heartbeat.svg",
                          height: screenWidth * 0.08,
                          width: screenWidth * 0.08,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "100 Bpm",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/weight.svg",
                          height: screenWidth * 0.08,
                          width: screenWidth * 0.08,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "1g",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleCheckupSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jadwal Check Up Selanjutnya",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0XFFFF899E),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/images/bidan.png",
                    height: screenWidth * 0.25,
                    width: screenWidth * 0.24,
                  ),
                  SizedBox(width: screenWidth * 0.06),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Dr. Linda Mutika Sari",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/calendar.svg",
                              height: screenWidth * 0.035,
                              width: screenWidth * 0.035,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              "16 Maret 2024, 10.10 WIB",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.topLeft,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                            ),
                            child: Text(
                              "Cek Jadwal",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                                color: const Color(0XFFFF899E),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
