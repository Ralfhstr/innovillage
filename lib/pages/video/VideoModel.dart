import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String title;
  final String videoUrl;

  VideoModel({required this.title, required this.videoUrl});
}

Future<List<VideoModel>> fetchVideos() async {
  try {
    // Assuming you have a 'videos' collection in Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('videos').get();

    // Extract video data from documents
    List<VideoModel> videos = querySnapshot.docs.map((doc) {
      return VideoModel(
        title: doc['title'] ?? '',
        videoUrl: doc['videoUrl'] ?? '',
      );
    }).toList();

    return videos;
  } catch (e) {
    print('Error fetching videos: $e');
    return [];
  }
}
