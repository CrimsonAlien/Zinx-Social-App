import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:zinx/models/user.dart';

class FirestoreService{
  final CollectionReference _usersCollectionReference= FirebaseFirestore.instance.collection('users');


Future CreateUser(FireUser user) async{
  //create a user collection table in firestore
  try{
await _usersCollectionReference.doc(user.id).set(user.toJson());
  }on FirebaseException catch(e){
    return e.message;
  }
}
Future checkUserName(String displayName)async{
//check if displayName exist in firestore
  var result=await _usersCollectionReference.where('displayName',isEqualTo:displayName).limit(1).get();
  final List<DocumentSnapshot> documents = result.docs;

return documents.length==1;


}

  Future<bool> checkemail(String email)async{
//check if email already exist in firestore
    var result=await _usersCollectionReference.where('email',isEqualTo:email).limit(1).get();
    final List<DocumentSnapshot> documents = result.docs;

    return documents.length==1;


  }

  Future getUser(String uid) async{

    try{
      var userdata= await _usersCollectionReference.doc(uid).get();
      return FireUser.fromData(userdata.get(userdata.data));

    }
    on FirebaseAuthException catch(e){
      return e.message;
    }
  }

}