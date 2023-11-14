import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('entries')
            .where('userId', isEqualTo: loggedInUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return BarChart(_createChartData(snapshot.data!.docs));
        },
      ),
    );
  }

  BarChartData _createChartData(List<DocumentSnapshot> docs) {
    Map<String, int> emoticonsCount = {};

    for (var doc in docs) {
      var data = doc.data() as Map<String, dynamic>;
      String emoticonKey = 'Emoticon: ${data['sliderValue']}';
      emoticonsCount.update(emoticonKey, (value) => ++value, ifAbsent: () => 1);
    }

    List<BarChartGroupData> barGroups = emoticonsCount.entries.map((entry) {
      int index = int.parse(entry.key.split(' ')[1]);
      return BarChartGroupData(
        x: index,
        barRods: [BarChartRodData(toY: entry.value.toDouble())],
      );
    }).toList();

    return BarChartData(
      barGroups: barGroups,
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false
          )
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) {
              return _getEmoticonIcon(value.toInt());
            },
          ),
        ),
      ),
      // Other BarChartData properties...
    );
  }

  Widget _getEmoticonIcon(int value) {
    switch (value) {
      case 0:
        return const Icon(Icons.sentiment_very_dissatisfied, size: 30);
      case 1:
        return const Icon(Icons.sentiment_dissatisfied, size: 30);
      case 2:
        return const Icon(Icons.sentiment_neutral, size: 30);
      case 3:
        return const Icon(Icons.sentiment_satisfied, size: 30);
      case 4:
        return const Icon(Icons.sentiment_very_satisfied, size: 30);
      default:
        return const Icon(Icons.error, size: 30);
    }
  }
}
