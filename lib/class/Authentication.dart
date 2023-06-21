import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signOut() async{
    return await _auth.signOut();
  }

  Future<User?> kullaniciOlustur(String name, String email, String password) async{
    try
    {
      var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("User").doc(user.user!.uid).set({
        "name": name,
        "email": email,
      });
      return user.user;
    }on FirebaseAuthException catch(e){
      switch(e.code)
      {
        case 'weak-password': Fluttertoast.showToast(
            msg: "Şifreyi 6 karakterden fazla giriniz",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0
        ); break;
        case 'email-already-in-use' : Fluttertoast.showToast(
            msg: "E-Mail Kullanılıyor.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 16.0
        ); break;
      }
    }
  }

  Future<User?> girisYap(String email, String password) async{
    try{
      var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user.user;
    } on FirebaseAuthException catch(e){
        switch(e.code)
        {
          case 'wrong-password': Fluttertoast.showToast(
              msg: "Şifre yanlış",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0
          ); break;
          case 'user-not-found': Fluttertoast.showToast(
              msg: "Kullanıcı bulunamadı",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0
          ); break;
        }
      }
    }
}