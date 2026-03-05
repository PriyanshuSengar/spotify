import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {
  
  String? email;
  String? fullName;
  String? imageURL;
  UserModel({this.email, this.fullName,this.imageURL });
   UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
   
  }
}
extension UserModelX on UserModel {
  UserEtity toEntity() {
    return UserEtity(
      email: email,
      fullName: fullName,
      imageURL: imageURL
    );
  }
}
