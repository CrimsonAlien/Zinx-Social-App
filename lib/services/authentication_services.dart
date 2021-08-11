

import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  Future loginWithEmail({
    required String email,
    required String password}) async{
  try{
    var user= await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
    return user;

  }catch(e){
return e;
  }
  }

  Future signupWithEmail({required String email,required String password}) async{
    try{
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);
      return userCredential.user !=null ;

    } on FirebaseAuthException catch (e) {

        return e.message;

    }

  }

  Future<bool> isUserLoggedin() async{
    var user = _firebaseAuth.currentUser;

    return user != null;

  }

/*Future checkEmail(String email) async {



try{
  var emailChecker = await _firebaseAuth.fetchSignInMethodsForEmail(email);


  return emailChecker;
}
catch(e){
  return e;
}

  } */


 Future sendVerificationLink() async{


  var user = _firebaseAuth.currentUser;
  if(user != null && !user.emailVerified) {

   try{
     await user.sendEmailVerification();
     print("link sent");

   }on FirebaseAuthException catch(e){
     return e.message;
   }
  }
return user != null;
}


Future checkEmailVerified() async{


try{
  var user = _firebaseAuth.currentUser;
  if(user !=null){
    await user.reload();

    try{

      if(user.emailVerified){
        print("verified");
        return user.emailVerified;
      }
    }on FirebaseAuthException catch(e){
      return e.message;

    }

  }
}on FirebaseAuthException catch(e){
  return e.message;
}



  }



}



