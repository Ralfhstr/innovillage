import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:innovillage/pages/home/home_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:innovillage/pages/video/video_list_screen.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  List<String> videoUrls = [];

  @override
  void initState() {
    super.initState();
    _restoreVideoUrls();
  }

  Future<void> _restoreVideoUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      videoUrls = prefs.getStringList('videoUrls') ?? [];
    });
  }

  Future<void> _saveVideoUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('videoUrls', videoUrls);
  }

  Future<void> _pickVideo() async {
    try {
      String? filePath = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'avi', 'mkv'],
      ).then((result) => result?.files.single.path);

      if (filePath != null) {
        // Check if the selected video URL already exists in videoUrls
        if (!videoUrls.contains(filePath)) {
          await _uploadToFirebaseStorage(filePath);

          // Navigate to VideoListScreen after uploading
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoListScreen(videoUrls: videoUrls),
            ),
          );
        } else {
          print("Video already exists in the list.");
        }
      } else {
        print("No video selected.");
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  Future<void> _uploadToFirebaseStorage(String filePath) async {
    try {
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(
                'videos/${DateTime.now().millisecondsSinceEpoch}.mp4',
              );

      final firebase_storage.UploadTask uploadTask = storageReference.putFile(
        File(filePath),
        firebase_storage.SettableMetadata(contentType: 'video/mp4'),
      );

      await uploadTask.whenComplete(() async {
        print('Video uploaded to Firebase Storage');
        final String downloadURL = await storageReference.getDownloadURL();

        // Add the downloadURL to the list
        setState(() {
          videoUrls.add(downloadURL);
        });

        // Save the videoUrls list
        await _saveVideoUrls();
      });
    } catch (e) {
      print("Error uploading video to Firebase Storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video File Picker'),
        leading: IconButton(
          // Add leading for back button
          icon: Icon(Icons.arrow_back), // Icon for back button
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePages()),
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text('Pick Video File'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoListScreen(videoUrls: videoUrls),
                ),
              );
            },
            child: Text('Lihat Video'),
          ),
        ],
      ),
    );
  }
}
