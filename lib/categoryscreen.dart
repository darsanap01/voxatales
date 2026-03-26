import 'package:flutter/material.dart';
import 'package:storyapplication/admin_login.dart';
import 'package:storyapplication/history.dart';
import 'package:storyapplication/home.dart';
import 'package:storyapplication/profile.dart';
import 'package:storyapplication/service/appdata.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  IconData _getIcon(String name) {
    switch (name) {
      case 'explore':
        return Icons.explore;
      case 'auto_awesome':
        return Icons.auto_awesome;
      case 'menu_book':
        return Icons.menu_book;
      case 'child_care':
        return Icons.child_care;
      case 'library_books':
        return Icons.library_books;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(AppData.currentUser?.name ?? 'User'),
              accountEmail: Text(AppData.currentUser?.email ?? 'No Email'),
              currentAccountPicture: const CircleAvatar(child: Icon(Icons.person, size: 35)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Stories'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => StoryScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: AppData.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final category = AppData.categories[index];
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => StoryScreen(category: category['title'])));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [Color(0xff89f7fe), Color(0xff66a6ff)]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_getIcon(category['icon']!), size: 45, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      category['title']!,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}