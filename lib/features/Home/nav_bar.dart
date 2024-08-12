import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/features/Home/main_view.dart';
import 'package:pitch_test/features/Presentation/Favourite/Favourite.dart';
import 'package:pitch_test/features/Presentation/Search/Search_view.dart';
import 'package:pitch_test/features/Presentation/booking/Booking_view.dart';
import 'package:pitch_test/features/Presentation/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> screens = [
    const Favourite_view(),
    const SearchView(),
    const Main_view(),
    const Booking_view(),
    const profile_view(),
  ];
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.color1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Favourite.svg'),
              activeIcon: SvgPicture.asset('assets/Favourite.svg',
                  colorFilter:
                      ColorFilter.mode(AppColors.color2, BlendMode.srcIn)),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/search.svg'),
              activeIcon: SvgPicture.asset('assets/search.svg',
                  colorFilter:
                      ColorFilter.mode(AppColors.color2, BlendMode.srcIn)),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Home.svg'),
              activeIcon: SvgPicture.asset('assets/Home.svg',
                  colorFilter:
                      ColorFilter.mode(AppColors.color2, BlendMode.srcIn)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/booking.svg',
                  colorFilter:
                      ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
              activeIcon: SvgPicture.asset('assets/booking.svg',
                  colorFilter: ColorFilter.mode(
                    AppColors.color2,
                    BlendMode.srcIn,
                  )),
              label: 'booking',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Profile.svg'),
              activeIcon: SvgPicture.asset('assets/Profile.svg',
                  colorFilter:
                      ColorFilter.mode(AppColors.color2, BlendMode.srcIn)),
              label: 'Profile',
            ),
          ]),
    );
  }
}
