import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mental_health/screens/detail_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final _firestore = FirebaseFirestore.instance;
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

  void _deleteEntry(String docId) async {
    await _firestore.collection('entries').doc(docId).delete();
  }

  _getSliderEmoticon(sliderEntryValue) {
    switch (sliderEntryValue) {
      case 0:
        return const Icon(Icons.sentiment_very_dissatisfied);
      case 1:
        return const Icon(Icons.sentiment_dissatisfied);
      case 2:
        return const Icon(Icons.sentiment_neutral);
      case 3:
        return const Icon(Icons.sentiment_satisfied);
      case 4:
        return const Icon(Icons.sentiment_very_satisfied);
      default:
        return const Icon(Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book,
                  size: 26,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Entries',
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('entries')
                .where('userId', isEqualTo: loggedInUser.uid)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (cxt, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final entries = snapshot.data!.docs;

              if (entries.isEmpty) {
                return const Center(
                  child: Text('No entries found'),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      var entry = entries[index].data() as Map<String, dynamic>;
                      var entryId = entries[index].id;
                      var entryDate = entry['entryDate']?.toDate();
                      var entryText = entry['entry'];
                      var entrySliderValue = entry['sliderValue'];

                      return ListTile(
                        title: Text(DateFormat('yMMMd').format(entryDate)),
                        subtitle: Text(
                          entryText,
                          maxLines: 2,
                        ),
                        leading: _getSliderEmoticon(entrySliderValue),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteEntry(entryId);
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EntryDetailScreen(entryData: entry),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
