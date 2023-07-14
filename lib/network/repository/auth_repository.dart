import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../util/screen_util.dart';
import '../auth_exception.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  const AuthRepository(this._auth);

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  ///---------------Sign In------------------
  //sign in with email password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    }
  }

  //sign in with facebook
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  //sign in with google account
  Future<void> signInWithGoogle() async {
    try {
      //trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        // if (userCredential.user != null) {
        //   if (userCredential.additionalUserInfo!.isNewUser) {
        //   //send user data to firestore
        //   }
        // }
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  //sign in with apple account
  Future<void> signInWithApple() async {}

  ///----------------Sign out------------------

  Future<void> signOut() async => await _auth.signOut();

  ///--------------Forgot password-------------

  Future<void> forgotPassword() async {}

  ///----------------Sign Up-----------------

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email Verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signUpWithPhoneNumber(
    BuildContext? context,
    String phoneNumber,
  ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (verificationId, resendToken) {
          //nav to otp screen
          if (context == null) {
            return;
          }
        },
        codeAutoRetrievalTimeout: (timeOut) {},
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    }
  }
}
