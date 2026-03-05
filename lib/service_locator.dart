import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_reposatory_impl.dart';
import 'package:spotify/data/repository/song/song_repository_impl.dart';
import 'package:spotify/data/sources/auth/auth_firebase_services.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signout.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify/domain/usecases/song/get_favorites_songs.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_play_list.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.asNewInstance();

Future<void> initilizeDependencies()async{
sl.registerSingleton<SongFirebaseServie>(SongFirebaseServiceImpl());
sl.registerSingleton<AuthFirebaseServices>(AuthFirebaseServiceImpl());
sl.registerSingleton<AuthRepository>(AuthReposatoryImpl());
sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
sl.registerSingleton<SignupUseCase>(SignupUseCase());
sl.registerSingleton<SignOutCase>(SignOutCase());
sl.registerSingleton<SigninUseCase>(SigninUseCase());
sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
}