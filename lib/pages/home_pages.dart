import 'package:flutter/material.dart';
import 'package:innovillage/pages/ibu_hamil.dart';
import 'package:innovillage/pages/lainnya.dart';
import 'package:innovillage/pages/menu_kehamilan.dart';
import 'package:innovillage/pages/pelayanan_dokter.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  var height, width;

  List imgData = [
    "assets/hamil.png",
    "assets/jadwal.png",
    "assets/grafik.png",
    "assets/lainnya.png",
  ];

  List titles = [
    "ibu hamil",
    "jadwal",
    "grafik",
    "lainnya",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            height = constraints.maxHeight;
            width = constraints.maxWidth;

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF427D9D),
                      ),
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            "HALO MAMA - Bidan",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: width,
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF427D9D),
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          height: width > height ? width * 0.15 : height * 0.15,
                          width: width,
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
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            color: Color(0xFF427D9D),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: height * 0.45,
                          //width: MediaQuery.of(context).size.height,
                          child: Expanded(
                            //width : MediaQuery.of(context).size.width* 0.8,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: width > height
                                    ? 4
                                    : 2, // Change crossAxisCount for landscape
                                childAspectRatio: 1.1,
                                mainAxisSpacing: width * 0.05,
                              ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: imgData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (titles[index] == "ibu hamil") {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => IbuHamil()),
                                          (route) => false);
                                      // Sesuaikan dengan nama rute layar ibu hamil
                                    } else if (titles[index] == "jadwal") {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MenuKehamilan()),
                                          (route) => false);
                                    } else if (titles[index] == "grafik") {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PelayananDokter()),
                                          (route) => false);
                                    } else if (titles[index] == "lainnya")
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Lainnya()),
                                          (route) => false);
                                    {}
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 11,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.01,
                                        horizontal: width * 0.05),
                                    padding: EdgeInsets.all(width * 0.03),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.02),
                                      color: Color(
                                        0xff9BBEC8,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          imgData[index],
                                          width: width * 0.2,
                                        ),
                                        Text(
                                          titles[index],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
