import 'package:flutter/material.dart';
import 'package:innovillage/pages/login%20pages/ibuhamil.dart';
import 'package:innovillage/pages/login%20pages/login_page.dart';
// Gantilah dengan file login ibu hamil yang sesuai

class Role extends StatefulWidget {
  const Role({Key? key}) : super(key: key);

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPages()),
                );
              },
              child: Text('Login Bidan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginIbu()),
                );
              },
              child: Text('Login Ibu Hamil'),
            ),
          ],
        ),
      ),
    );
  }
}
