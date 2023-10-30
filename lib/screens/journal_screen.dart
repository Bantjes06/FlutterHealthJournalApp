import 'package:flutter/material.dart';
import 'package:mental_health/widgets/emoticon_slider.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start writing'),
        centerTitle: true,
      ),
      body: const Center(
        child: EmoticonSlider(),
      ),
    );
  }
}