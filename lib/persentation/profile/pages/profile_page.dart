import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';

import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/data/models/auth/signout_user_req.dart';

import 'package:spotify/domain/usecases/auth/signout.dart';
import 'package:spotify/persentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/persentation/home/pages/home.dart';
import 'package:spotify/persentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/persentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/persentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/persentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/service_locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            );
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color:
                  context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 15,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xff2C2B2B),
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await sl<SignOutCase>().call(
                params: SignoutUserReq(),
              );
              result.fold(
                (l) {
                  var snackbar = SnackBar(
                    content: Text(l),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                (r) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const SignupOrSignin(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(state.userEntity.imageURL!),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        transform: Matrix4.translationValues(5, 5, 0),
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
                          Icons.camera_alt_outlined,
                          color:
                              context.isDarkMode
                                  ? Color(0xff959595)
                                  : const Color(0xff555555),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(state.userEntity.email!),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return Text('Please try again ');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    List<String> image = [
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Drake_-_In_My_Feelings_tivzqw.jpg',

      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338768/Enrique_Iglesias_-_Tonight_ehdxog.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Ed_Sheeran_-_Shape_Of_You_svpbqc.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Rihanna_-_Diamonds_thttzi.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Calvin_Harris_Dua_Lipa_-_One_Kiss_ruwb7d.jpg',
      'https://res.cloudinary.com/dqwxpu0zd/image/upload/v1772338767/Billie_Eilish_Khalid_-_lovely_eebo8i.jpg',
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
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FAVORITES SONGS'),
            SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                image: DecorationImage(
                                  image: NetworkImage(image[index]),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songName[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                          ],
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, length) => const SizedBox(height: 10),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Text('Please try again');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
