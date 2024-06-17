import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:ichat/common/loader.dart";
import "package:ichat/common/widgets/custom_button.dart";
import "package:ichat/features/auth/controller/auth_controller.dart";

class LoginScreen extends ConsumerWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final sizedbox12 = SizedBox(
      height: size.height / 12,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Lets Begin"),
          centerTitle: true,
        ),
        body: Center(
                child: Column(
                  children: [
                    sizedbox12,
                    Image.asset('assets/bg.jpg'),
                    sizedbox12,
                    const Text(
                      'First register your account',
                      style: TextStyle(fontSize: 20),
                    ),
                    const LoginButton(),
                  ],
                ),
              ));
  }
}

class LoginButton extends ConsumerWidget {
  void signInWithGoogle(BuildContext context,WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle(context);
  }

  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () => signInWithGoogle(context,ref),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.g_mobiledata,
              size: 60,
            ),
            Text(
              "Sign in from Google",
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
