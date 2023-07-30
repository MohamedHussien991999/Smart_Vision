// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_farm/layout/cubit/states_layout.dart';
import 'package:smart_farm/modules/detection_plant/detaction_plant_video.dart';
import 'package:smart_farm/modules/home/home_screen.dart';
import 'package:smart_farm/modules/profile/Profile.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:video_player/video_player.dart';
import '../../config/constants.dart';
import '../../config/route/scale_route.dart';
import '../../modules/chat/community_screen.dart';
import '../../modules/detection_plant/detaction_plant_image.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';

class PlantLayoutCubit extends Cubit<PlantLayoutStates> {
  int currentIndex = 0;
  late List<BottomBarItem> bottomItems;
  PlantLayoutCubit() : super(PlantLayoutInitialState()) {
    bottomItems = [
      BottomBarItem(
          icon: SvgPicture.asset(
            'assets/svg/Home.svg',
            colorFilter:
                const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            'assets/svg/Home.svg',
            colorFilter:
                const ColorFilter.mode(activeColorIndicator, BlendMode.srcIn),
          ),
          title: const Text('Home')),
      BottomBarItem(
          icon: SvgPicture.asset(
            'assets/svg/Chat.svg',
            colorFilter:
                const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            'assets/svg/Chat.svg',
            colorFilter:
                const ColorFilter.mode(activeColorIndicator, BlendMode.srcIn),
          ),
          title: const Text('Community ')),
      BottomBarItem(
          icon: SvgPicture.asset(
            'assets/svg/Icon.svg',
            colorFilter:
                const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
          ),
          selectedIcon: SvgPicture.asset(
            'assets/svg/Icon.svg',
            colorFilter:
                const ColorFilter.mode(activeColorIndicator, BlendMode.srcIn),
          ),
          title: const Text('Profile')),
      BottomBarItem(
          icon: SvgPicture.asset(
            'assets/svg/setting.svg',
            height: 30.0,
          ),
          selectedIcon: SvgPicture.asset(
            'assets/svg/setting.svg',
            height: 25.0,
            colorFilter:
                const ColorFilter.mode(activeColorIndicator, BlendMode.srcIn),
          ),
          title: const Text('Settings')),
    ];
  }

  static PlantLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(
      isEmpty: plantModelFinal?.plantsHistory == null ? true : false,
    ),
    const ChatScreen(),
    const Profile(),
    const SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(PlantLayoutBottomNavBarState());
  }

  File? image;
  File? video;

  void detectPlant(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 50);
                image = File(pickedFile!.path);
                imageDetection = image;
                if (image != null) {
                  Navigator.push(
                      context,
                      ScaleRoute(
                          page: PlantDetectionsImageScreen(
                              imageFound: FileImage(image!))));
                } else {
                  Navigator.push(
                      context,
                      ScaleRoute(
                          page: PlantDetectionsImageScreen(
                              imageFound: const AssetImage(
                                  "assets/images/image_not_found.jpg"))));
                }
              },
              child: const Row(
                children: [
                  Icon(
                    FontAwesomeIcons.camera,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Take A photo',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 50);
                image = File(pickedFile!.path);
                imageDetection = image;
                if (image != null) {
                  Navigator.push(
                      context,
                      ScaleRoute(
                          page: PlantDetectionsImageScreen(
                              imageFound: FileImage(image!))));
                } else {
                  Navigator.push(
                      context,
                      ScaleRoute(
                          page: PlantDetectionsImageScreen(
                              imageFound: const AssetImage(
                                  "assets/images/image_not_found.jpg"))));
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.wallpaper,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Get A photo From Gallery',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile =
                    await picker.pickVideo(source: ImageSource.camera);
                videoDetection = File(pickedFile!.path);
                Navigator.push(
                    context,
                    ScaleRoute(
                        page: PlantDetectionsVideoScreen(
                            video:
                                VideoPlayerController.file(videoDetection!))));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.videocam,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Make A video ',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile =
                    await picker.pickVideo(source: ImageSource.gallery);
                videoDetection = File(pickedFile!.path);
                Navigator.push(
                    context,
                    ScaleRoute(
                        page: PlantDetectionsVideoScreen(
                            video:
                                VideoPlayerController.file(videoDetection!))));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.view_sidebar_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Get A Video From Gallery',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
