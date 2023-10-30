import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/screens/journal_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Container(height: 500, width: 500, child: const Center(child: Text('Mood chart will be displayed here, placeholder only'))),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const JournalScreen(),
                      ),
                    );
                  },
                  child: const Text('Start Journaling'))
            ],
          ),
        ),
      ),
    );
  }
}
