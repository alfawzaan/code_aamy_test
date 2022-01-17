import 'dart:convert';

import 'package:code_aamy_test/model/credential.dart';
import 'package:code_aamy_test/model/studentlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Repository {
  Future<Credentials> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      debugPrint("GoogleSignInAccount ${googleUser?.email}");

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      debugPrint("GoogleSignInAuthentication${googleAuth?.accessToken}");

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );


      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential, );
      debugPrint("User Details0 ${userCredential.user?.displayName}");

      debugPrint("User Details1 ${userCredential.user?.email}");
      return Credentials.fromResponse(userCredential);
    } catch (e, str) {
      debugPrint("Message $e");
      debugPrint("Trace $str");
      return Credentials.withError("Error signing in!");
    }
  }


  Future<StudentList> getStudentList() async{
    try {
      String jsonText = await rootBundle.loadString("assets/dummy_data.json");
      var jsonObj = json.decode(jsonText);
      debugPrint("$jsonObj");
      return StudentList.fromJson(jsonObj);
    } catch (e,str) {
      debugPrint("$e");
      debugPrint("$str");
      return StudentList.withError("Error loading students");
    }
  }
}
