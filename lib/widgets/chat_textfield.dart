import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.cyan,
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              color: Colors.cyan,
              // color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Message..."),
            ),
          ),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyan,
            ),
            child: Icon(
              Icons.keyboard_voice,
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
