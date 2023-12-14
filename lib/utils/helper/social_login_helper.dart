import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginHelper {
  static Future<AuthorizationCredentialAppleID?> loginWithApple() async {
    try {
      final  AuthorizationCredentialAppleID   appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: 'example-nonce',
      );
      debugPrint('User ID: ${appleIdCredential.userIdentifier}');
      debugPrint('Email: ${appleIdCredential.email}');
      debugPrint('Given Name: ${appleIdCredential.givenName}');
      debugPrint('Family Name: ${appleIdCredential.familyName}');
      debugPrint('Identity Token: ${appleIdCredential.identityToken}');
      debugPrint('Authorization Code: ${appleIdCredential.authorizationCode}');
      return appleIdCredential;
    } catch (e) {
      debugPrint('Error during Apple Sign In: $e');
    }
    return null;
  }

  static Future<GoogleSignInAccount?> loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      if (await googleSignIn.isSignedIn()) {
        googleSignIn.signOut();
      }
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleUser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      if (googleUser == null) {
        // User canceled the sign-in process.
        return null;
      }
      debugPrint('User ID: ${googleUser.id}');
      debugPrint('Display Name: ${googleUser.displayName}');
      debugPrint('Email: ${googleUser.email}');
      debugPrint('ID Token: ${credential.token}');
      debugPrint('Access Token: ${credential.accessToken}');
      return googleUser;
    } catch (e) {
      debugPrint('Error during Google Sign-In: $e');
    }
    return null;
  }

  static Future<AccessToken?> loginWithFacebook() async {
    /*  {
  "email" = "dsmr.apps@gmail.com",
  "id" = 3003332493073668,
  "name" = "Darwin",
  "picture" = {
  "data" = {
  "height" = 50,
  "is_silhouette" = 0,
  "url" = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=3003332493073668",
  "width" = 50,
  },
  }
  }*/

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // You can now use the `accessToken` to sign in or register the user.
        // For example, send the user's access token to your server for validation.

        debugPrint('User ID: ${accessToken.userId}');
        debugPrint('Token: ${accessToken.token}');
        debugPrint('Expires: ${accessToken.expires}');
        return accessToken;
      } else {
        // Handle other status cases (e.g., error, canceled).
        debugPrint('Error during Facebook Sign-In: ${result.status}');
      }
    } catch (e) {
      debugPrint('Error during Facebook Sign-In: $e');
    }
    return null;
  }
}
