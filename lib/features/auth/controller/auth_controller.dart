import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ichat/features/auth/repository/auth_repository.dart';
import 'package:ichat/models/user_model.dart';
import 'package:riverpod/riverpod.dart';

// final userProvider = StateProvider<UserModel?>((ref) => null);

// final authControllerProvider = StateNotifierProvider<AuthController, bool>(
//     (ref) => AuthController(
//         authRepository: ref.watch(authRepositoryProvider), ref: ref));
// final authStateChangeProvider = StreamProvider(
//   (ref) {
//     final authController = ref.watch(authControllerProvider.notifier);
//     return authController.authStateChange;
//   },
// );

// final getUserDataProvider = StreamProvider.family((ref, String uid) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.getUserData(uid);
// });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository _authRepository;
//   final Ref _ref;
//   AuthController({required AuthRepository authRepository, required Ref ref})
//       : _authRepository = authRepository,
//         _ref = ref,
//         super(false);

//   Stream<User?> get authStateChange => _authRepository.authStateChange;

//   void signInWithGoogle(BuildContext context) async {
//     final user = await _authRepository.singInWithGoogle();
//     state = false;
//     user.fold(
//         (l) => showSnackBar(context, l.message),
//         (userModel) =>
//             _ref.read(userProvider.notifier).update((state) => userModel));
//   }

//   Stream<UserModel> getUserData(String uid) {
//     return _authRepository.getUserData(uid);
//   }
// }
final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithGoogle(BuildContext context) {
    authRepository.singInWithGoogle(context: context);
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    authRepository.setUserState(isOnline);
  }
}
