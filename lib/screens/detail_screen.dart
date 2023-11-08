import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key, required this.entryData});
  final Map<String, dynamic> entryData;
  @override
  Widget build(BuildContext context) {
    DateTime entryDate = entryData['entryDate'].toDate();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(DateFormat('yMMMd').format(entryDate)),
      ),
    );
  }
}