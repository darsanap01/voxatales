import 'dart:convert';

import 'package:flutter/widgets.dart';

List<Story> storyFromJson(String str) => List<Story>.from(json.decode(str).map((x) => Story.fromJson(x)));

class Story {
  final int id;
  final String title;
  final String description;
  final String text;
  final String image ;
    final String audioPath; 


  Story({
    required this.id,
    required this.title,
    required this.description,
    required this.text,
    required this.image,
    required this.audioPath
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    text: json["text"],
    image: json["image"],
    audioPath: json["audio_path"]
  );
}
