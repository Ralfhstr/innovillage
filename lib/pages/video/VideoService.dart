import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovillage/pages/video/VideoModel.dart';

class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<VideoModel>> fetchVideos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('videos').get();

      List<VideoModel> videos = querySnapshot.docs.map((doc) {
        return VideoModel(
          title: doc['title'] as String,
          videoUrl: doc['videoUrl'] as String,
        );
      }).toList();

      return videos;
    } catch (e) {
      print("Error fetching videos: $e");
      throw e; // Rethrow the error to handle it in the UI
    }
  }
}
