import 'package:flutter/material.dart';
import 'package:storyapplication/service/appdata.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Story History')),
      body: AppData.history.isEmpty
          ? const Center(child: Text('No story viewed yet'))
          : ListView.builder(
              itemCount: AppData.history.length,
              itemBuilder: (context, index) {
                final story = AppData.history[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(story.title),
                    subtitle: Text(story.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
    );
  }
}