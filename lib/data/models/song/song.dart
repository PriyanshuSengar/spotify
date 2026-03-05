import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool ? isFavorite;
   String ? songId;
  SongModel({
    required this.releaseDate,
    required this.artist,
    required this.duration,
    required this.title,
    required this.isFavorite,
  });
  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
  }
}

// ignore: camel_case_extensions
extension songModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      releaseDate: releaseDate!,
      artist: artist!,
      duration: duration!,
      isFavorite: isFavorite!,
      title: title!,
      songId: songId!
    );
  }
}
