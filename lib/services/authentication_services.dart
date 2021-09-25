

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zinx/models/user.dart';
import 'package:zinx/services/firestore_service.dart';

import '../locator.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirestoreService _firestoreService=locator<FirestoreService>();

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

  Future signupWithEmail({required String email,required String password,required String username,required photoUrl,required displayName,required bio}) async{
    try{
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      await _firestoreService.CreateUser(FireUser(
        id: userCredential.user!.uid,
        email: email,
        username:username,
        photoUrl:photoUrl,
        displayName:displayName,
        bio:bio,

      ));


      return userCredential.user !=null ;

    } on FirebaseAuthException catch (e) {

        return e.message;

    }

  }

  Future<bool> isUserLoggedin() async{
    var user = _firebaseAuth.currentUser;

    return user != null;

  }
  Future checkEmail(String email) async {



try{
  var emailChecker = await _firebaseAuth.fetchSignInMethodsForEmail(email);


  return emailChecker;
}
on FirebaseAuthException catch(e){
  return e.message;
}

  }



Future<bool>checkDisplayName({required String displayName}) async{



 var result= await _firestoreService.checkUserName(displayName);

 return result;





  }

  Future<bool>checkEmailExist({required String email}) async{

    var result= await _firestoreService.checkemail(email);

    return result;

  }


}



