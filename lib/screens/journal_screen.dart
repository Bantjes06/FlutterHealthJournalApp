import 'package:flutter/material.dart';
import 'package:mental_health/widgets/emoticon_slider.dart';
import 'package:intl/intl.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start writing'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Pick an emotion with the slider below',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(
            height: 25,
          ),
          const EmoticonSlider(),
          const SizedBox(
            height: 40,
          ),
          _selectedDate == null
              ? const Text('No date selected')
              : Text(
                  'Date: ${DateFormat('yMMMd').format(_selectedDate!)}',
                  style: const TextStyle(fontSize: 16),
                ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != DateTime.now()) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: const Text('Select date'),
          ),
          const Divider(
            thickness: 0.5,
            indent: 30,
            endIndent: 30,
            height: 40,
          ),
          const Text('What are you feeling?',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              label: Text('Type here..'),
                              border: InputBorder.none),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              const SnackBar(
                                content: Text('You need to write something'),
                              );
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Save Entry'))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
