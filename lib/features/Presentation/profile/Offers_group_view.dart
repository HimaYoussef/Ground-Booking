import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Presentation/Profile/Profile_view.dart';
import 'package:pitch_test/features/Presentation/Profile/widgets/Offers_group.dart';

class Offers_group_view extends StatefulWidget {
  const Offers_group_view({super.key});

  @override
  State<Offers_group_view> createState() => _Offers_group_viewState();
}

class _Offers_group_viewState extends State<Offers_group_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, profile_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          'Offers group order',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Offers_view(
                Head: 'Offers group Week',
                Body:
                    'Repeated installations per week at the same stadiums receive a discount ',
                Percent: '%15'),
            Gap(10),
            Offers_view(
                Head: 'Offers group Month',
                Body:
                    'Repeated installations per month at the same stadiums receive a discount  ',
                Percent: '%10'),
            Gap(10),
            Offers_view(
                Head: 'Offers group Year',
                Body:
                    'Choose the months of the year that are appropriate for me to book at a discount ',
                Percent: '%5'),
            Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color1,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Booking ",
                      style: getbodyStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
