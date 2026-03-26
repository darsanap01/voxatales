import 'package:flutter/services.dart' show rootBundle;
import 'package:storyapplication/models/stories.dart';
import 'dart:convert';

Future<List<Story>> loadStories() async {
  final String response = await rootBundle.loadString('assets/json/stories.json');
  final List<Story> stories = storyFromJson(response);
  return stories;
}
