import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/rekam%20medis%20ibu%20hamil/menu_kehamilan.dart';

class StatusKehamilan extends StatefulWidget {
  const StatusKehamilan({super.key});

  @override
  State<StatusKehamilan> createState() => _StatusKehamilanState();
}

class _StatusKehamilanState extends State<StatusKehamilan> {
  var width, height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF427D9D),
                ),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuKehamilan()),
                            (route) => false);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF427D9D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.width * 0.2,
                    width: width,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Data Rekam Medis',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
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
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('rekammedis')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return ListTile(
                            title: Text(
                              'Tipe Kunjungan: ${data['TipeKunjungan']}\n'
                              'Tanggal Kunjungan: ${data['tanggalkunjungan']}\n'
                              'Timbang: ${data['timbang']}\n'
                              'Ukur Lingkar Lengan Atas: ${data['UkurLingkarLengatatas']}\n'
                              'Tekanan Darah: ${data['tekanandarah']}\n'
                              'Periksa Tinggi Rahim: ${data['PeriksaTinggiRahim']}\n'
                              'Letak Dan Denyut Jantung Janin: ${data['Imunisasi']}\n'
                              'Status Dan Imunisasi Tetanus: ${data['Imunisasi']}\n'
                              'Konseling: ${data['Konseling']}\n'
                              'Tablet Dan Tambah Darah: ${data['tablet']}\n',
                              style: TextStyle(
                                color:
                                    Colors.white, // Set the text color to white
                              ),
                            ),

                            // subtitleTextStyle: Text(data['Keluhan']),

                            // Add more fields as needed
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
