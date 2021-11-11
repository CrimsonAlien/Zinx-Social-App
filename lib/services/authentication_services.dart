

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
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

  Future<bool> sendOtp(String email) async{
EmailAuth.sessionName="Zinx session";
var result = await EmailAuth.sendOtp(receiverMail: email);
return result;

  }


  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email address is not in use
        return false;
      }
    } catch (e) {
      // Handle error
      // ...
      return false;
    }
  }







  Future<String> checkDisplayName({required String displayName}) async{

   var result= await _firestoreService.checkUserName(displayName);
   return result;

  }

  Future<bool>checkEmailExist({required String email}) async{

    var result= await _firestoreService.checkemail(email);

    return result;

  }


}



