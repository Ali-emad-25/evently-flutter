import 'package:evently/firebase_utils.dart';
import 'package:evently/models/my_user.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthService {
  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> continueWithGoogle(BuildContext context) async {
    try {
      DialogUtils.showLoading(context: context, text: 'loading...');

      final credential = await signInWithGoogle();

      final firebaseUser = credential.user!;

      MyUser? myUser = await FirebaseUtils.getUserInFirestore(firebaseUser.uid);

      if (myUser == null) {
        myUser = MyUser(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );

        await FirebaseUtils.addUserInFirestore(myUser);
      }

      if (!context.mounted) return;

      Provider.of<UserProvider>(context, listen: false).userUpdate(myUser);

      DialogUtils.hideLoading(context: context);

      ToastUtils.showToast(
        text: 'login_successfully',
        backgroundColor: Theme.of(context).primaryColor,
      );

      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    } catch (e) {
      DialogUtils.hideLoading(context: context);

      ToastUtils.showToast(text: '$e', backgroundColor: AppColors.redColor);
    }
  }
}
