import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuthentication = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken:  googleAuthentication.accessToken,
        idToken:  googleAuthentication.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}