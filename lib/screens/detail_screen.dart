import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key, required this.entryData, required this.onValueToEmoticon});
  final Map<String, dynamic> entryData;
      final Function(int) onValueToEmoticon;
  @override
  Widget build(BuildContext context) {
    DateTime entryDate = entryData['entryDate'].toDate();
    int emoteValue = entryData['sliderValue'];
    String entryText = entryData['entry'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(DateFormat('yMMMd').format(entryDate)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Center(child: onValueToEmoticon(emoteValue),),
          const SizedBox(height: 80,),
          Padding(padding: const EdgeInsets.only(left: 5, right: 5), child: Text(entryText))
        ],
      )
      
    );
  }
}