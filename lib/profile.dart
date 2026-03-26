import 'package:flutter/material.dart';
import 'package:storyapplication/service/appdata.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppData.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: user == null
          ? const Center(child: Text('No user logged in'))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 55)),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name'),
                      subtitle: Text(user.name),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(user.email),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Password'),
                      subtitle: Text(user.password),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}