import 'package:flutter/material.dart';
import 'package:storyapplication/service/appdata.dart';
import 'package:storyapplication/service/load_json.dart';
import 'package:storyapplication/models/stories.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  late Future<List<Story>> _storiesFuture;
  List<Story> _stories = [];

  @override
  void initState() {
    super.initState();
    _storiesFuture = loadStories();
    _storiesFuture.then((value) => setState(() => _stories = value));
  }

  void _deleteStory(int index) {
    setState(() {
      AppData.deleteStory(_stories[index].id);
      _stories.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Story removed from manage list')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Stories')),
      body: FutureBuilder<List<Story>>(
        future: _storiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && _stories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_stories.isEmpty) {
            return const Center(child: Text('No stories available'));
          }
          return ListView.builder(
            itemCount: _stories.length,
            itemBuilder: (context, index) {
              final story = _stories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.book)),
                  title: Text(story.title),
                  subtitle: Text(story.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteStory(index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}