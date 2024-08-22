import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ManagerSalesView(),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          image: const DecorationImage(
                              opacity: .5, image: AssetImage('assets/11.png'))),
                      child: Text(
                        'Sales',
                        style: getTitleStyle(
                                color: AppColors.scaffoldBG, fontSize: 36)
                            .copyWith(
                          fontFamily: GoogleFonts.khand().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ManagerMenuView(),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          image: const DecorationImage(
                              opacity: .5, image: AssetImage('assets/22.png'))),
                      child: Text(
                        'Menu',
                        style: getTitleStyle(
                                color: AppColors.scaffoldBG, fontSize: 36)
                            .copyWith(
                          fontFamily: GoogleFonts.khand().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ManagerOfferView(),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          image: const DecorationImage(
                              opacity: .5, image: AssetImage('assets/33.png'))),
                      child: Text(
                        'Offers',
                        style: getTitleStyle(
                                color: AppColors.scaffoldBG, fontSize: 36)
                            .copyWith(
                          fontFamily: GoogleFonts.khand().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ManagerTopRatedView(),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          image: const DecorationImage(
                              opacity: .5, image: AssetImage('assets/44.png'))),
                      child: Text(
                        'Top Rates',
                        style: getTitleStyle(
                                color: AppColors.scaffoldBG, fontSize: 36)
                            .copyWith(
                          fontFamily: GoogleFonts.khand().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const ManagerReportedView(),
                      //   ),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          image: const DecorationImage(
                              opacity: .5, image: AssetImage('assets/55.png'))),
                      child: Text(
                        'Reports',
                        style: getTitleStyle(
                                color: AppColors.scaffoldBG, fontSize: 36)
                            .copyWith(
                          fontFamily: GoogleFonts.khand().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
              ],
            )),
      ),
    );
  }
}
