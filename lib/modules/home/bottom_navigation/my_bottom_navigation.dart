import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/constants.dart';
import '../../../config/route/scale_route.dart';
import '../../profile/Profile.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key, selectedIndex}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 2) {
        Navigator.push(context, ScaleRoute(page: const Profile()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: selectedIndex == 0
                ? SvgPicture.asset(
                    'assets/svg/Home.svg',
                    colorFilter: const ColorFilter.mode(
                        activeColorIndicator, BlendMode.srcIn),
                  )
                : SvgPicture.asset(
                    'assets/svg/Home.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                  ),
            label: 'Home',
            tooltip: 'Home'),
        BottomNavigationBarItem(
          icon: selectedIndex == 1
              ? SvgPicture.asset(
                  'assets/svg/Chat.svg',
                  colorFilter: const ColorFilter.mode(
                      activeColorIndicator, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/svg/Chat.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 2
              ? SvgPicture.asset(
                  'assets/svg/Icon.svg',
                  colorFilter: const ColorFilter.mode(
                      activeColorIndicator, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/svg/Icon.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                ),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: selectedIndex == 3
              ? SvgPicture.asset(
                  'assets/svg/setting.svg',
                  height: 25.0,
                  colorFilter: const ColorFilter.mode(
                      activeColorIndicator, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/svg/setting.svg',
                  height: 25.0,
                ),
          label: 'settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFFF6925C),
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
