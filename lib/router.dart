//logedout
//logged in

import 'package:flutter/material.dart';
import 'package:ichat/common/error_text.dart';
import 'package:ichat/features/auth/screens/login_screen.dart';
import 'package:ichat/screens/chat_screen.dart';
import 'package:ichat/screens/new_account.dart';

// final loggedOutRoute =
//     RouteMap(routes: {'/': (_) => const MaterialPage(child: LoginScreen())});

// final loggedInRoute = RouteMap(
//     routes: {'/': (_) => const MaterialPage(child: MobileScreenLayout())});

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case CreateAccount.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateAccount(),
      );
    // case SelectContactsScreen.routeName:
    //   return MaterialPageRoute(
    //     builder: (context) => const SelectContactsScreen(),
    //   );
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          profilePic: profilePic,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorText(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
