import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ichat/features/auth/controller/auth_controller.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 30),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(foregroundColor: Colors.cyan),
    );
  }
}

// class LoginButton extends StatelessWidget {
//   final String text;
//   const LoginButton({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Text(text),
//       onPressed: () {},
//     );
//   }
// }


