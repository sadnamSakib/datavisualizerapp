import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on firebase user
  user? _userFromFirebaseUser(User? firebaseUser){
    return firebaseUser != null ? user(uid: firebaseUser.uid) : null;
  }

  //auth change user stream
  Stream<user?> get firebaseUser{
    return _auth.authStateChanges()
    .map((User? firebaseUser) => _userFromFirebaseUser(firebaseUser));
  }
  //sign in anon

Future signinAnon() async{
  try{
    UserCredential result = await _auth.signInAnonymously();
    User? user = result.user;
    return user;
  }catch(e){
    print(e.toString());
    return null;
  }
}

  //sign in with email and password

  Future signinWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}