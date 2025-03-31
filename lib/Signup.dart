import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/Home.dart';
import 'package:untitled/Email.dart';

class Signup extends StatelessWidget {
   Signup({super.key});

  final FirebaseAuth auth  = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn  = GoogleSignIn();


  Future<void> signInWithEmail () async{

  }
  Future<void> signInWithPhone () async{

  }

  Future<void> signInWithGoogle (BuildContext context) async{
    try {
   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
   final AuthCredential credential = GoogleAuthProvider.credential(
   accessToken: googleSignInAuthentication.accessToken,
   idToken: googleSignInAuthentication.idToken

   );
   await auth.signInWithCredential(credential);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
   } catch(e){
    print(e);
   }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 250,
              width: 250,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>Email()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Sign in with Email',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: signInWithPhone,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Sign in with Phone',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                signInWithGoogle(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Sign in with Google',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
