import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat/common/repositiories/firebase_storage_repo.dart';
import 'package:ichat/common/utils.dart';
import 'package:ichat/models/user_model.dart';
import 'package:ichat/screens/app_layout.dart';
import 'package:ichat/screens/new_account.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      googleSignIn: GoogleSignIn()),
);

class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthRepository({
    required this.firestore,
    required this.auth,
    required this.googleSignIn,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<dynamic> singInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        CreateAccount.routeName,
        (route) => false,
      );

      // if (userCredential.additionalUserInfo!.isNewUser){
      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateAccount(),),);
      // }
      // else{

      // }
      // late UserModel userModel;
      // if (userCredential.additionalUserInfo!.isNewUser) {
      // userModel = UserModel(
      //     name: userCredential.user!.displayName ?? 'No Name',
      //     uid: userCredential.user!.uid,
      //     profilePic: userCredential.user!.photoURL ?? '',
      //     isOnline: true);
      // Routemaster.of(context).push('');
      // await _users.doc(userModel.uid).set(userModel.toMap());
      // }else {
      //   userModel = await getUserData(userCredential.user!.uid).first;
      // }
      // return right(userModel);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profilePic/$uid',
              profilePic,
            );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        email: auth.currentUser!.email!,
        friends: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MobileLayoutScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
