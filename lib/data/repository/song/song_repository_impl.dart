import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
// import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseServie>().getNewSongs();
  }
  
  @override
  Future<Either> getPlayList()async {
    return await sl<SongFirebaseServie>().getPlayList();
    
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) {
    // TODO: implement addOrRemoveFavoriteSong
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) {
    // TODO: implement isFavoriteSong
    throw UnimplementedError();
  }
   
 
} 