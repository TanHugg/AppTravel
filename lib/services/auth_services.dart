import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  //Google Sign in
  signInWithGoogle() async{
    //begin
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}