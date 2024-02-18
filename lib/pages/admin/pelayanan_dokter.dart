import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/catatan/catatandokter.dart';
import 'package:innovillage/pages/home%20pages/home_pages.dart';
import 'package:innovillage/theme.dart';

class PelayananDokter extends StatefulWidget {
  const PelayananDokter({Key? key}) : super(key: key);

  @override
  State<PelayananDokter> createState() => _PelayananDokterState();
}

class _PelayananDokterState extends State<PelayananDokter> {
  var height, width;

  final keluhan = TextEditingController();
  final tanggalkembali = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController _tanggalPemeriksaController = TextEditingController();
  TextEditingController _tanggalKembaliController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> pelayana_dokter() async {
    if (_tanggalPemeriksaController.text.isNotEmpty &&
        keluhan.text.isNotEmpty &&
        _tanggalKembaliController.text.isNotEmpty) {
      try {
        await firestore.collection("catatan").add({
          "Tanggal Pemeriksa": _tanggalPemeriksaController.text,
          "Keluhan": keluhan.text,
          "Tanggal Kembali": _tanggalKembaliController.text,
          "createdAt": DateTime.now().toIso8601String()
        });
        // Perbarui tampilan setelah data berhasil disimpan
        setState(() {
          // Lakukan hal apa pun yang diperlukan untuk memperbarui tampilan
          // misalnya, panggil metode fetchData() untuk memperbarui daftar data
        });
      } catch (e) {
        print("error");
      }
    }
  }

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
                          MaterialPageRoute(builder: (context) => HomePages()),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF427D9D),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ringkasan Pelayanan Dokter',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('catatan')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text(
                                    'Terjadi kesalahan: ${snapshot.error}');
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var document = snapshot.data!.docs[index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        'Keluhan: ${document['Keluhan']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      subtitle: Text(
                                        'Tanggal Pemeriksa: ${document['Tanggal Pemeriksa']}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Form Pelayanan Dokter'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _tanggalPemeriksaController,
                        onTap: () =>
                            _selectDate(context, _tanggalPemeriksaController),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Pemeriksa',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: keluhan,
                        decoration: InputDecoration(
                          labelText: 'Keluhan',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _tanggalKembaliController,
                        onTap: () =>
                            _selectDate(context, _tanggalKembaliController),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Kembali',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await pelayana_dokter();
                          Navigator.of(context).pop();
                        },
                        child: Text('Simpan'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF427D9D),
      ),
    );
  }
}
