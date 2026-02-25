import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseServices {
  Future<Either> signup(CreateUserReq createuserreq);
  Future<Either> signin(SigninUserReq signinuserreq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseServices {
  @override
  Future<Either> signin(SigninUserReq signinuserreq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinuserreq.email,
        password: signinuserreq.password,
      );

      return const Right('Signin was Successfull');
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'worng password provided for that user';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createuserreq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createuserreq.email,
        password: createuserreq.password,
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createuserreq.fullName,
        'email': data.user?.email,
      });
      return const Right('Signup was Successfull');
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'weak password') {
        message = 'This passowrd provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }
      return Left(message);
    }
  }
}
