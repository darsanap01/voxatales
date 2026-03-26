import 'package:storyapplication/models/stories.dart';
import 'package:storyapplication/models/usermodels.dart';

class AppData {
  static UserModel? currentUser;

  static final List<Map<String, String>> categories = [
    {'title': 'Adventure', 'icon': 'explore'},
    {'title': 'Fantasy', 'icon': 'auto_awesome'},
    {'title': 'Moral', 'icon': 'menu_book'},
    {'title': 'Kids', 'icon': 'child_care'},
    {'title': 'Classic', 'icon': 'library_books'},
    {'title': 'Funny', 'icon': 'sentiment_very_satisfied'},
  ];

  static final List<Story> history = [];

  static final List<Map<String, String>> adminUsers = [
    {'username': 'admin', 'password': '1234'},
  ];

  static void addToHistory(Story story) {
    history.removeWhere((item) => item.id == story.id);
    history.insert(0, story);
  }

  static void deleteStory(int id) {
    history.removeWhere((story) => story.id == id);
  }
}