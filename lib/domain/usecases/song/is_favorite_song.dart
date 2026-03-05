import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({params})async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
  
}
