import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:innovillage/pages/home/home_pages.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoListScreen extends StatefulWidget {
  final List<String> videoUrls;

  VideoListScreen({required this.videoUrls});

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    // Initialize VideoPlayerController if there are videoUrls
    if (widget.videoUrls.isNotEmpty) {
      _controller = VideoPlayerController.network(widget.videoUrls.first)
        ..initialize().then((_) {
          setState(() {}); // Update the state when initialization is complete
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> deleteVideoFromFirebase(String videoUrl) async {
    try {
      Reference videoRef = FirebaseStorage.instance.refFromURL(videoUrl);
      await videoRef.delete();
      print(
          'Video at URL $videoUrl successfully deleted from Firebase Storage.');
    } catch (e) {
      print('Error deleting video from Firebase Storage: $e');
    }
  }

  Future<void> handleVideoDeletion(int index) async {
    await deleteVideoFromFirebase(widget.videoUrls[index]);

    setState(() {
      widget.videoUrls.removeAt(index);
    });

    // Save the updated videoUrls list
    await _saveVideoUrls();
  }

  Future<void> _showVideoDialog(int index) async {
    _controller = VideoPlayerController.network(widget.videoUrls[index]);
    await _controller.initialize();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            children: [
              !_controller.value.isInitialized
                  ? Center(child: CircularProgressIndicator())
                  : FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
              Positioned(
                top: 8,
                right: 8,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (_controller.value.isPlaying) {
                          await _controller.pause();
                        } else {
                          await _controller.play();
                        }
                        if (mounted) {
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        }
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await handleVideoDeletion(index);
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    ).then((_) {
      if (!_controller.value.isPlaying) {
        _controller.pause();
      }
      _controller.dispose();
    });
  }

  Future<void> _saveVideoUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('videoUrls', widget.videoUrls);
  }

  Future<void> _resetVideoList() async {
    // Delete all videos from Firebase Storage
    for (String videoUrl in widget.videoUrls) {
      await deleteVideoFromFirebase(videoUrl);
    }

    // Clear the video list and add the new video as the first item
    widget.videoUrls.clear();
    widget.videoUrls.add(_controller.dataSource!);

    // Save the updated videoUrls list
    await _saveVideoUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePages()),
                (route) => false);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.videoUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  onTap: () async {
                    if (_controller.value.isPlaying) {
                      await _controller.pause();
                    }

                    _showVideoDialog(index);

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt('selectedVideoIndex', index);
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _resetVideoList,
            child: Text('Reset Video List'),
          ),
        ],
      ),
    );
  }
}
