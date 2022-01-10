import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ContextualMessage extends StatelessWidget {
  final String text;
  final String textColor;
  ContextualMessage({required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(34, 8, 34, 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: HexColor(textColor),
          ),
        ),
      ),
    );
  }
}
