// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class AuthService {
//   /// ------- Google Sign In --------
//   static Future<SocialInfo?> signinWithGoogle() async {
//     try {
//       GoogleSignInAccount? user = await (GoogleSignIn().signIn());

//       GoogleSignInAuthentication auth = await user!.authentication;

//       AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: auth.accessToken, idToken: auth.idToken);

//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       User? userInfo = userCredential.user;

//       print("Google Signin: -> ${{
//         'name': userInfo?.displayName,
//         'email': userInfo?.email,
//         'phone': userInfo?.phoneNumber,
//         'profile_image': userInfo?.photoURL,
//         'socile_id': userInfo?.uid,
//       }}");
//       return SocialInfo(
//           socialId: userInfo?.uid ?? '',
//           email: userInfo?.email,
//           firstName: userInfo?.displayName == null
//               ? null
//               : userInfo?.displayName!.split(' ').first,
//           lastName: userInfo?.displayName == null
//               ? null
//               : userInfo?.displayName!.split(' ').last,
//           profileImage: userInfo?.photoURL);
//     } catch (e) {
//       print("Google Sign Exp: $e");
//     }
//     return null;
//   }

//   /// ------- Apple Sign In --------
//   static String _sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   static Future<SocialInfo?> signinWithApple() async {
//     try {
//       final rawNonce = generateNonce();
//       final nonce = _sha256ofString(rawNonce);
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: nonce,
//       );
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         rawNonce: rawNonce,
//       );
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(oauthCredential);

//       print("Apple Signin: -> ${{
//         'name': "${userCredential.user?.displayName}",
//         'email': userCredential.user?.email,
//         'socile_id': userCredential.user?.uid,
//       }}");

//       return SocialInfo(
//           socialId: userCredential.user?.uid ?? '',
//           email: userCredential.user?.email,
//           firstName: userCredential.user?.displayName == null
//               ? null
//               : userCredential.user?.displayName!.split(' ').first,
//           lastName: userCredential.user?.displayName == null
//               ? null
//               : userCredential.user?.displayName!.split(' ').last);
//     } catch (e) {
//       print("Apple Sign In Exp: $e");
//     }
//     return null;
//   }
// }

// class SocialInfo {
//   final String socialId;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? profileImage;
//   SocialInfo(
//       {required this.socialId,
//       this.email,
//       this.firstName,
//       this.lastName,
//       this.profileImage});
// }

// // Google Signin: -> {name: Praween Kumar, email: pkumar.link@gmail.com, phone: null, profile_image: https://lh3.googleusercontent.com/a/AAcHTtd4by8YhxjXUgM17MmBSmfIVvEvrwqnWB6PXauRoiGo7Is=s96-c, socile_id: 3KFsMpHIvDbXPsOWoVkcik3NtZ53};

// // AuthorizationAppleID(000933.b5202dd4ff444d7da261664cff07dfec.1253, A, Kumar, developer@cqlsys.co.uk, example-state)