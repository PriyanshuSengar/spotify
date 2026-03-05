import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/signout_user_req.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SignOutCase implements UseCase<Either, SignoutUserReq> {
  @override
  Future<Either> call({SignoutUserReq? params}) async {
    return sl<AuthRepository>().signout(params!);
  }
}
