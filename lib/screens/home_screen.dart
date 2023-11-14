import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/screens/journal_screen.dart';
import 'package:mental_health/widgets/chart.dart';
import 'package:mental_health/widgets/drawer.dart';

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
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Mood Stats', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
              Container(height: 500, child: const Chart()),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 25),
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
