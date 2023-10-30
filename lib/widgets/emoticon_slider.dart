import 'package:flutter/material.dart';

class EmoticonSlider extends StatefulWidget {
  const EmoticonSlider({super.key});

  @override
  State<EmoticonSlider> createState() => _EmoticonSliderState();
}

class _EmoticonSliderState extends State<EmoticonSlider> {
  int _sliderValue = 2;  // Default value

  final List<IconData> emoticons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          emoticons[_sliderValue],
          size: 50,
        ),
        Slider(
          value: _sliderValue.toDouble(),
          min: 0,
          max: (emoticons.length - 1).toDouble(),
          divisions: emoticons.length - 1,
          onChanged: (value) {
            setState(() {
              _sliderValue = value.round();
            });
          },
        ),
      ],
    );
  }
}