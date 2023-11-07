import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    getCurrentUser();
  }

  void getCurrentUser() async {
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
                .where('sender', isEqualTo: loggedInUser.email)
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
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      var entry = entries[index].data() as Map<String, dynamic>;
                      var entryDate = entry['entryDate']?.toDate();
                      var entryText = entry['entry'];

                      return ListTile(
                        title: Text(DateFormat('yMMMd').format(entryDate)),
                        subtitle: Text(entryText),
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
