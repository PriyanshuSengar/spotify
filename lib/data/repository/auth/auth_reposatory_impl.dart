import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/models/auth/signout_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthReposatoryImpl extends AuthRepository{

  
  @override
  Future<Either> signin(SigninUserReq signinuserreq)async {
    return await sl<AuthFirebaseServices>().signin(signinuserreq);
  }
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
     return  await sl<AuthFirebaseServices>().signup(createUserReq);
  
  }
  
  @override
  Future<Either> getUser()async {
     return  await sl<AuthFirebaseServices>().getUser();
  }
  
  @override
  Future<Either> signout(SignoutUserReq signoutuserreq)async {
     return  await sl<AuthFirebaseServices>().signout(signoutuserreq);
  }
}