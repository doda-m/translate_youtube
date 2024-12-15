import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YouTubePlayerScreen(),
    );
  }
}

class YouTubePlayerScreen extends StatefulWidget {
  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  final TextEditingController _controller = TextEditingController();
  YoutubePlayerController? _youtubePlayerController;

  void _loadVideo() {
    final videoId = YoutubePlayerController.convertUrlToId(_controller.text);
    if (videoId != null) {
      _youtubePlayerController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: false,
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    _youtubePlayerController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter YouTube URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loadVideo,
              child: Text('Load Video'),
            ),
            SizedBox(height: 20),
            if (_youtubePlayerController != null)
              YoutubePlayer(
                controller: _youtubePlayerController!,
              ),
          ],
        ),
      ),
    );
  }
}