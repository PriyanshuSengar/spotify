import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;

  SongEntity({
    required this.releaseDate,
    required this.artist,
    required this.isFavorite,
    required this.duration,
    required this.title,
    required this.songId,
  });
}
