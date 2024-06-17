import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ichat/common/error_text.dart';
import 'package:ichat/common/loader.dart';
import 'package:ichat/features/auth/controller/auth_controller.dart';
import 'package:ichat/features/auth/screens/login_screen.dart';
import 'package:ichat/firebase_options.dart';
import 'package:ichat/router.dart';
import 'package:ichat/screens/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I-Chat',
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData.dark(),
      home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                return const LoginScreen();
              }
              return const MobileLayoutScreen();
            },
            error: (err, trace) {
              return ErrorText(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
