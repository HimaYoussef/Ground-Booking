import 'package:flutter/material.dart';
import 'package:pitch_test/LocalProvider.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Edit_profile.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Help_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/profile_view.dart';
import 'package:pitch_test/generated/l10n.dart';
import 'package:provider/provider.dart';

class Settings_view extends StatefulWidget {
  const Settings_view({super.key});

  @override
  State<Settings_view> createState() => _Settings_viewState();
}

class _Settings_viewState extends State<Settings_view> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, profile_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          S.of(context).Settings_head,
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
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  pushTo(context, Edit_Profile());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: AppColors.color2,
                      )),
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).Settings_Edit_account_button,
                      style: getbodyStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (localeProvider.locale.languageCode == 'en') {
                    localeProvider.setLocale(const Locale('ar'));
                  } else {
                    localeProvider.setLocale(const Locale('en'));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: AppColors.color2,
                      )),
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).Settings_language_button,
                      style: getbodyStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  pushTo(context, Help_view());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: AppColors.color2,
                      )),
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).Settings_Help_button,
                      style: getbodyStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
