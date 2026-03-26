import 'package:flutter/material.dart';
import 'package:storyapplication/models/stories.dart';
import 'package:storyapplication/service/audio_playback.dart';
import 'package:storyapplication/service/tts_service.dart';

class StoryDetailScreen extends StatefulWidget {
  final Story story;

  const StoryDetailScreen({super.key, required this.story});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final TtsService _ttsService = TtsService();
  final AudioService audioService=AudioService();
  bool isPlaying = false;
  bool isAudioPlaying = false;

  bool  isPlaying2=false;
  bool isAudioPlaying2=false;


  @override
  void initState() {
    super.initState();
    _ttsService.init();
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.story.image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              widget.story.text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),
          Center(
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
 
IconButton(
  icon: const Icon(Icons.replay_10, color: Colors.white),
  onPressed: () async {
    await audioService.seekBackward();
    setState(() {
      isPlaying2 = true;
    });
  },
),
     IconButton(
          icon: Icon(
            isAudioPlaying2 ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 36,
            color: Colors.white,
          ),
          onPressed: () {
            if (isAudioPlaying2) {
              audioService.pauseAudio();
            } else {
              audioService.play(widget.story.audioPath);
            }

            setState(() {
              isAudioPlaying2 = !isAudioPlaying2;
            });
          },
        ),


           IconButton(
  icon: const Icon(Icons.forward_10, color: Colors.white),
  onPressed: () async {
    await audioService.seekForward();
    setState(() {
      isPlaying2 = true;
    });
  },
),

      ],
    ),
  ),
),


            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_10),
                    iconSize: 32,
                    onPressed: () {
                      _ttsService.speak(widget.story.text);
                      setState(() {
                        isPlaying = true;
                      });
                    },
                  ),

                  const SizedBox(width: 12),

                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                    ),
                    iconSize: 48,
                    color: Colors.orange,
                    onPressed: () {
                      if (isPlaying) {
                        _ttsService.stop();
                      } else {
                        _ttsService.speak(widget.story.text);
                      }
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                  ),
                  

                  const SizedBox(width: 12),

                  IconButton(
                    icon: const Icon(Icons.forward_10),
                    iconSize: 32,
                    onPressed: () {
                      _ttsService.speak(
                        widget.story.text.substring(
                          widget.story.text.length ~/ 2,
                        ),
                      );
                      setState(() {
                        isPlaying = true;
                      });
                    },
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
