import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:innovillage/pages/home/home_pages.dart';

class LoginIbu extends StatefulWidget {
  const LoginIbu({Key? key}) : super(key: key);

  @override
  State<LoginIbu> createState() => _LoginIbuState();
}

class _LoginIbuState extends State<LoginIbu> {
  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();

  void cariData() async {
    String nik = nikController.text;
    String nama = namaController.text;

    // Ambil data dari Firebase Firestore
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("ibuhamil")
        .where("nik", isEqualTo: nik)
        .where("nama", isEqualTo: nama)
        .get()
        .then((value) => value.docs.first);

    if (snapshot.exists) {
      // Jika data ditemukan, navigasi ke HomePages dengan menyertakan data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePages(),
        ),
      );
    } else {
      // Jika data tidak ditemukan, tampilkan pesan atau aksi yang sesuai
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data tidak ditemukan. Coba lagi.'),
        ),
      );
    }
  }

  // Fungsi untuk mendapatkan data dari server
  Future<bool> getDataFromServer(String nik, String nama) async {
    // Implementasi logika untuk mendapatkan data dari server
    // ...
    // Gantilah dengan logika sesuai kebutuhan aplikasi Anda

    // Contoh sederhana: Anggap data ditemukan jika NIK dan Nama bukan string kosong
    return nik.isNotEmpty && nama.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login Ibu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nikController,
              decoration: InputDecoration(
                labelText: 'NIK',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cariData();
              },
              child: Text('Cari Data'),
            ),
          ],
        ),
      ),
    );
  }
}
