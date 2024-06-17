import 'package:flutter/material.dart';
import 'package:ichat/common/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizedbox12 = SizedBox(
      height: size.height / 12,
    );

    return Scaffold(
      // backgroundColor: color,
      body: SafeArea(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedbox12,
              Text(
                "Welcome to I-Chat",
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.w800),
              ),
              sizedbox12,
              Image.asset(
                'assets/bg.jpg',
                // width: size.width,
                height: size.height / 3,
              ),
              sizedbox12,
              Text(
                "Have a comfortable chatting experience",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
              ),
              sizedbox12,
              CustomButton(text: "Continue", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
