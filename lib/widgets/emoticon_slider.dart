import 'package:flutter/material.dart';

class EmoticonSlider extends StatelessWidget {
  EmoticonSlider({super.key, required this.sliderValue, required this.onEmoticonChanged});
  final int sliderValue;
  final Function(int) onEmoticonChanged;

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
          emoticons[sliderValue],
          size: 50,
        ),
        Slider(
          value: sliderValue.toDouble(),
          min: 0,
          max: (emoticons.length - 1).toDouble(),
          divisions: emoticons.length - 1,
          onChanged: (value) => onEmoticonChanged(value.round()),
        ),
      ],
    );
  }
}
