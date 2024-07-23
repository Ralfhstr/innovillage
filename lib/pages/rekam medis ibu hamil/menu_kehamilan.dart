import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/home/home_pages.dart';
import 'package:innovillage/pages/rekam%20medis%20ibu%20hamil/status_kehamilan.dart';

class MenuKehamilan extends StatefulWidget {
  const MenuKehamilan({Key? key});

  @override
  State<MenuKehamilan> createState() => _MenuKehamilanState();
}

class _MenuKehamilanState extends State<MenuKehamilan> {
  final tipekunjungan = TextEditingController();
  final tanggalkunjungan = TextEditingController();
  final timbang = TextEditingController();
  final ukurlingkarlengatas = TextEditingController();
  final tekanandarah = TextEditingController();
  final periksatinggirahim = TextEditingController();
  final letakdandenyutjantung = TextEditingController();
  final imunisasi = TextEditingController();
  final konseling = TextEditingController();
  final tablet = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> rekamMedisList = [];

  @override
  void initState() {
    super.initState();
    getDataRekamMedis();
  }

  void getDataRekamMedis() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('rekammedis').get();
    setState(() {
      rekamMedisList = snapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> rekam_medis() async {
    if (tipekunjungan.text.isNotEmpty &&
        tanggalkunjungan.text.isNotEmpty &&
        timbang.text.isNotEmpty &&
        ukurlingkarlengatas.text.isNotEmpty &&
        tekanandarah.text.isNotEmpty &&
        periksatinggirahim.text.isNotEmpty &&
        letakdandenyutjantung.text.isNotEmpty &&
        imunisasi.text.isNotEmpty &&
        konseling.text.isNotEmpty &&
        tablet.text.isNotEmpty) {
      try {
        await firestore.collection("rekammedis").doc().set({
          "TipeKunjungan": tipekunjungan.text,
          "tanggalkunjungan": tanggalkunjungan.text,
          "timbang": timbang.text,
          "UkurLingkarLengatatas": ukurlingkarlengatas.text,
          "tekanandarah": tekanandarah.text,
          "PeriksaTinggiRahim": periksatinggirahim.text,
          "letakdandenyutjantung": letakdandenyutjantung.text,
          "Imunisasi": imunisasi.text,
          "Konseling": konseling.text,
          "tablet": tablet.text,
          "createdAt": DateTime.now().toIso8601String()
        });
        // Memperbarui data rekam medis setelah ditambahkan
        getDataRekamMedis();
      } catch (e) {
        print("error");
      }
    }
  }

  late double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePages()),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "HALO MAMA - Bidan",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF427D9D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: height * 0.1,
                  width: width,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'REKAM MEDIS IBU HAMIL',
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
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: MediaQuery.of(context).size.width * 50,
                height: MediaQuery.of(context).size.width * 2.6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rekamMedisList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRekamMedisPage(
                                rekamMedisData: rekamMedisList[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Tipe Kunjungan: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      rekamMedisList[index]['TipeKunjungan'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Tanggal Kunjungan: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      rekamMedisList[index]['tanggalkunjungan'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Tambah Rekam Medis'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: tipekunjungan,
                        decoration:
                            InputDecoration(labelText: 'Tipe Kunjungan'),
                      ),
                      TextFormField(
                        controller: tanggalkunjungan,
                        decoration:
                            InputDecoration(labelText: 'Tanggal Kunjungan'),
                      ),
                      TextFormField(
                        controller: timbang,
                        decoration: InputDecoration(labelText: 'Timbang'),
                      ),
                      TextFormField(
                        controller: ukurlingkarlengatas,
                        decoration: InputDecoration(
                            labelText: 'Ukur Lingkar Lengan Atas'),
                      ),
                      TextFormField(
                        controller: tekanandarah,
                        decoration: InputDecoration(labelText: 'Tekanan Darah'),
                      ),
                      TextFormField(
                        controller: periksatinggirahim,
                        decoration:
                            InputDecoration(labelText: 'Periksa Tinggi Rahim'),
                      ),
                      TextFormField(
                        controller: letakdandenyutjantung,
                        decoration: InputDecoration(
                            labelText:
                                'Periksa Letak dan Denyut Jantung Janin'),
                      ),
                      TextFormField(
                        controller: imunisasi,
                        decoration: InputDecoration(
                            labelText: 'Status dan Imunisasi Tetanus'),
                      ),
                      TextFormField(
                        controller: konseling,
                        decoration: InputDecoration(labelText: 'Konseling'),
                      ),
                      TextFormField(
                        controller: tablet,
                        decoration:
                            InputDecoration(labelText: 'Tablet Tambah Darah'),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await rekam_medis();
                      Navigator.of(context).pop();
                    },
                    child: Text('Tambah'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class DetailRekamMedisPage extends StatelessWidget {
  final Map<String, dynamic> rekamMedisData;

  const DetailRekamMedisPage({Key? key, required this.rekamMedisData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Rekam Medis'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildItem('Tipe Kunjungan', rekamMedisData['TipeKunjungan']),
            buildItem('Timbang', rekamMedisData['timbang']),
            buildItem('Ukur Lingkar Lengan Atas',
                rekamMedisData['UkurLingkarLengatatas']),
            buildItem('Tekanan Darah', rekamMedisData['tekanandarah']),
            buildItem(
                'Periksa Tinggi Rahim', rekamMedisData['PeriksaTinggiRahim']),
            buildItem('Periksa Letak dan Denyut Jantung Janin',
                rekamMedisData['letakdandenyutjantung']),
            buildItem(
                'Status dan Imunisasi Tetanus', rekamMedisData['Imunisasi']),
            buildItem('Konseling', rekamMedisData['Konseling']),
            buildItem('Tablet Tambah Darah', rekamMedisData['tablet']),
          ],
        ),
      ),
    );
  }

  Widget buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            //SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MenuKehamilan(),
  ));
}
