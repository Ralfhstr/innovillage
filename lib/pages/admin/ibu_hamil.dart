import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovillage/pages/home pages/home_pages.dart';

class IbuHamil extends StatefulWidget {
  const IbuHamil({Key? key});

  @override
  State<IbuHamil> createState() => _IbuHamilState();
}

class _IbuHamilState extends State<IbuHamil> {
  final nama = TextEditingController();
  final nik = TextEditingController();
  final pembiayaan = TextEditingController();
  final tanggal = TextEditingController();
  final nojkn = TextEditingController();
  final alamat = TextEditingController();
  final darah = TextEditingController();
  final pekerjaan = TextEditingController();
  final pendidikan = TextEditingController();
  final telepon = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> tambah() async {
    if (nama.text.isNotEmpty &&
        nik.text.isNotEmpty &&
        pembiayaan.text.isNotEmpty &&
        tanggal.text.isNotEmpty &&
        nojkn.text.isNotEmpty &&
        alamat.text.isNotEmpty &&
        darah.text.isNotEmpty &&
        pekerjaan.text.isNotEmpty &&
        pendidikan.text.isNotEmpty &&
        telepon.text.isNotEmpty) {
      try {
        await firestore.collection("ibuhamil").add({
          "nama": nama.text,
          "nik": nik.text,
          "pembiayaan": pembiayaan.text,
          "tanggal": tanggal.text,
          "nojkn": nojkn.text,
          "alamat": alamat.text,
          "darah": darah.text,
          "pekerjaan": pekerjaan.text,
          "pendidikan": pendidikan.text,
          "telepon": telepon.text,
          "createdAt": DateTime.now().toIso8601String()
        });
        Navigator.pop(context, nama.text);
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Color(0xFF427D9D),
                leading: IconButton(
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
                title: Text(
                  "HALO MAMA",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Color(0xFF427D9D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Registrasi Ibu Hamil',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Kecamatan Kalipare',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20),
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
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('ibuhamil').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return ListView(
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailIbuHamil(
                                  data: data,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Warna latar belakang
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Warna bayangan
                                  spreadRadius: 2, // Radius penyebaran bayangan
                                  blurRadius: 3, // Radius blur bayangan
                                  offset: Offset(
                                      0, 2), // Penyesuaian posisi bayangan
                                ),
                              ],
                              border: Border.all(color: Colors.grey), // Border
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama: ${data['nama']}'),
                                Text('NIK: ${data['nik']}'),
                                // Add other data fields here
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Tambah Data Ibu Hamil'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nama,
                        decoration: InputDecoration(
                          labelText: 'Nama',
                        ),
                      ),
                      TextFormField(
                        controller: nik,
                        decoration: InputDecoration(
                          labelText: 'NIK',
                        ),
                      ),
                      TextFormField(
                        controller: pembiayaan,
                        decoration: InputDecoration(
                          labelText: 'Pembiayaan',
                        ),
                      ),
                      TextFormField(
                        controller: tanggal,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                        ),
                      ),
                      TextFormField(
                        controller: nojkn,
                        decoration: InputDecoration(
                          labelText: 'NO.JKN',
                        ),
                      ),
                      TextFormField(
                        controller: alamat,
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                        ),
                      ),
                      TextFormField(
                        controller: darah,
                        decoration: InputDecoration(
                          labelText: 'Golongan Darah',
                        ),
                      ),
                      TextFormField(
                        controller: pekerjaan,
                        decoration: InputDecoration(
                          labelText: 'Pekerjaan',
                        ),
                      ),
                      TextFormField(
                        controller: pendidikan,
                        decoration: InputDecoration(
                          labelText: 'Pendidikan',
                        ),
                      ),
                      TextFormField(
                        controller: telepon,
                        decoration: InputDecoration(
                          labelText: 'Telepon',
                        ),
                      ),
                      // Add TextFormFields for input data inside the dialog
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tambah();
                      Navigator.of(context).pop();
                      setState(() {}); // Update the UI after adding data
                    },
                    child: Text('Simpan'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class DetailIbuHamil extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailIbuHamil({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Ibu Hamil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Nama: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['nama']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'NIK: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['nik']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Pembiayaan: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['pembiayaan']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Tanggal Lahir: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['tanggal']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'NO.JKN: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['nojkn']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Alamat: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['alamat']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Golongan Darah: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['darah']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Pekerjaan: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['pekerjaan']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Pendidikan: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['pendidikan']),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Warna latar belakang
                borderRadius: BorderRadius.circular(10), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Warna bayangan
                    spreadRadius: 2, // Radius penyebaran bayangan
                    blurRadius: 3, // Radius blur bayangan
                    offset: Offset(0, 2), // Penyesuaian posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    'Telepon: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(data['telepon']),
                ],
              ),
            ),
            // Add other data fields here
          ],
        ),
      ),
    );
  }
}
