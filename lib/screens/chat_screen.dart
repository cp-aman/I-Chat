import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ichat/common/loader.dart';
import 'package:ichat/features/auth/controller/auth_controller.dart';
import 'package:ichat/models/user_model.dart';
import 'package:ichat/widgets/chat_list.dart';
import 'package:ichat/widgets/chat_textfield.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String profilePic;
  const ChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          // elevation: 10,
          centerTitle: false,
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        snapshot.data!.profilePic,
                        fit: BoxFit.cover,
                        height: 56,
                        width: 56,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          snapshot.data!.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        snapshot.data!.isOnline
                            ? const Text(
                                'Active now',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.green),
                              )
                            : const Text(
                                'offline',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.red),
                              ),
                      ],
                    ),
                  ],
                );
              }),
          leading: const InkWell(
            child: Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.keyboard_voice_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(
                child: ChatList(),
              ),
              Container(
                // color: Colors.cyan,
                child: ChatTextField(),
              )
            ],
          ),
        ));
  }
}
