import 'package:flutter/material.dart';
import 'package:storyapplication/manage_screen.dart';
import 'package:storyapplication/service/appdata.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _card('Categories', AppData.categories.length.toString(), Icons.category)),
                const SizedBox(width: 12),
                Expanded(child: _card('History', AppData.history.length.toString(), Icons.history)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _card('Users', AppData.currentUser == null ? '0' : '1', Icons.people)),
                const SizedBox(width: 12),
                Expanded(child: _card('Stories', '2+', Icons.menu_book)),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text('Go to Manage Stories'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  ManageScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, size: 38, color: Colors.blue),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}