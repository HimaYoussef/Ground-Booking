import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/profile/profile_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/widgets/Offers_group.dart';
import 'package:pitch_test/generated/l10n.dart';

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
           S.of(context).Offers_group_head,
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
                Head: S.of(context).Offers_group_Head_offers1,
                Body:
                    S.of(context).Offers_group_Body_offers1,
                Percent: S.of(context).Offers_group_Percent_offers1),
            Gap(10),
            Offers_view(
                Head:S.of(context).Offers_group_Head_offers2,
                Body:
                    S.of(context).Offers_group_Body_offers2,
                Percent: S.of(context).Offers_group_Percent_offers2),
            Gap(10),
            Offers_view(
                Head:S.of(context).Offers_group_Head_offers3,
                Body:
                    S.of(context).Offers_group_Body_offers3,
                Percent: S.of(context).Offers_group_Percent_offers3),
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
                      S.of(context).Offers_group_Booking_Button,
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
