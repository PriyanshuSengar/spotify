import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_reposatory_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';

final sl = GetIt.asNewInstance();

Future<void> initilizeDependencies()async{
sl.registerSingleton<AuthFirebaseServices>(AuthFirebaseServiceImpl());
sl.registerSingleton<AuthRepository>(AuthReposatoryImpl());
sl.registerSingleton<SignupUseCase>(SignupUseCase());
sl.registerSingleton<SigninUseCase>(SigninUseCase());
}