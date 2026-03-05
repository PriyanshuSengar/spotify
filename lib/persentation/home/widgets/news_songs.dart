import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/persentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify/persentation/home/bloc/news_songs_state.dart';
import 'package:spotify/persentation/song_player.dart/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key, gName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    List<String> list = [
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Drake_-_In_My_Feelings_tivzqw.jpg',

      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338768/Enrique_Iglesias_-_Tonight_ehdxog.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Ed_Sheeran_-_Shape_Of_You_svpbqc.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Rihanna_-_Diamonds_thttzi.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Calvin_Harris_Dua_Lipa_-_One_Kiss_ruwb7d.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Billie_Eilish_Khalid_-_lovely_eebo8i.jpg',
    ];
    List<String> song = [
      'https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772428789/Drake_-_In_My_Feelings_Naijaremix_ar6ne3.mp3',
      "https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772640168/sigmamusicart-song-english-edm-296526_qehvmk.mp3",
      "https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772640190/jherwen-bring-me-back-283196_yrp4gr.mp3",
      "https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772640196/hitslab-classical-royal-english-music-486078_bwzolx.mp3",
      "https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772640200/u_tb5l28tvgs-raghav-raj-lyrical-english-447685_lgfjn8.mp3",
      "https://res.cloudinary.com/dqwxpu0zd/video/upload/v1772640213/suryanatta-the-song-of-alone-410791_tbhcvg.mp3",
    ];
    List<String> songName = [
      "In My Feelings",
      "lovely",
      "Shape Of You",
      "One Kiss",
      "Diamonds",
      "Tonight",
    ];
    List<String> singerName = [
      "Drake",
      "Billie Eilish , Khalid",
      "Ed Sheeran",
      "Calvin Harris , Dua Lipa",
      "Rihana",
      "Enrique lglesias",
    ];

    return ListView.separated(
      itemCount: song.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(
          child: GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (BuildContext context) => SongPlayerPage(
                          songEntity: songs.first,
                          duration: '',
                          url: song[index],
                          artistName: singerName[index],
                          songName: songName[index],
                          imagePath:list[index]
                        ),
                  ),
                ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(list[index]),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  transform: Matrix4.translationValues(
                                    10,
                                    10,
                                    0,
                                  ),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        context.isDarkMode
                                            ? AppColors.darkgrey
                                            : const Color(0xffE6E6E6),
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color:
                                        context.isDarkMode
                                            ? Color(0xff959595)
                                            : const Color(0xff555555),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    songName[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    singerName[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 14);
      },
    );
  }
}
