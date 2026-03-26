import 'package:flutter/material.dart';
import 'package:storyapplication/models/stories.dart';
import 'package:storyapplication/service/appdata.dart';
import 'package:storyapplication/service/load_json.dart';
import 'package:storyapplication/service/tts_service.dart';

class StoryScreen extends StatefulWidget {
  final String? category;

  const StoryScreen({super.key, this.category});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late Future<List<Story>> _storiesFuture;
  final TtsService _ttsService = TtsService();
  Story? _currentStory;

  @override
  void initState() {
    super.initState();
    _storiesFuture = loadStories();
    _ttsService.init();
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }

  void _playStory(Story story) {
    _ttsService.speak(story.text);
    AppData.addToHistory(story);
    setState(() {
      _currentStory = story;
    });
  }

  void _stopStory() {
    _ttsService.stop();
    setState(() {
      _currentStory = null;
    });
  }

  void _showFullStory(Story story) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(story.title),
        content: SingleChildScrollView(
          child: Text(
            story.text,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              _playStory(story);
            },
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              _stopStory();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null
              ? 'Story Telling App'
              : '${widget.category} Stories',
        ),
      ),
      body: FutureBuilder<List<Story>>(
        future: _storiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final allStories = snapshot.data!;

            final stories = widget.category == null
                ? allStories
                : allStories
                    .where(
                      (story) =>
                          story.category.toLowerCase() ==
                          widget.category!.toLowerCase(),
                    )
                    .toList();

            if (stories.isEmpty) {
              return Center(
                child: Text(
                  'No stories found for ${widget.category}',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                final isPlaying = _currentStory?.id == story.id;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        story.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(isPlaying ? Icons.stop : Icons.volume_up),
                      onPressed: () {
                        if (isPlaying) {
                          _stopStory();
                        } else {
                          _playStory(story);
                        }
                      },
                    ),
                    onTap: () => _showFullStory(story),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No stories found'));
          }
        },
      ),
    );
  }
}