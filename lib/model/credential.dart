import 'package:firebase_auth/firebase_auth.dart';

class Credentials{
  UserCredential? credential;
  String error = "";
  Credentials(this.credential);

  Credentials.fromResponse(this.credential);

  Credentials.withError(this.error);

}