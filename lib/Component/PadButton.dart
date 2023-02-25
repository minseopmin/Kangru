import 'package:flutter/material.dart';

class PadButton extends StatelessWidget {
  const PadButton(
      {super.key, required this.materialButton, required this.colour});
  final MaterialButton materialButton;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: materialButton,
      ),
    );
  }
}
