import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/persentation/home/bloc/play_list_cubit.dart';
import 'package:spotify/persentation/home/bloc/play_list_state.dart';
import 'package:spotify/persentation/song_player.dart/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PlayList',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xffC6C6C6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _songs(state.songs),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    List<String> image = [
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
    List<String> duration = [
      "03:37",
      "02:37",
      "02:44",
      "02.15",
      "03:09",
      "03:23",
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (BuildContext context) => SongPlayerPage(
                        songEntity: songs.first,
                        url: song[index],
                        songName: songName[index],
                        artistName: singerName[index],
                        imagePath: image[index],
                        duration: '',
                      ),
                ),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          context.isDarkMode
                              ? AppColors.darkgrey
                              : Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color:
                          context.isDarkMode
                              ? const Color(0xff959595)
                              : const Color(0xff555555),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songName[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        singerName[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(duration[index]),
                  SizedBox(width: 10),
                  FavoriteButton(songEntity: songs.first),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: image.length,
    );
  }
}
