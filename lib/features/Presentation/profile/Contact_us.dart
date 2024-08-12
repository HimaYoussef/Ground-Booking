import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Presentation/profile/more%20inquiries.dart';
import 'package:pitch_test/features/Presentation/profile/profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_us_view extends StatefulWidget {
  const Contact_us_view({super.key});

  @override
  State<Contact_us_view> createState() => _Contact_us_viewState();
}

class _Contact_us_viewState extends State<Contact_us_view> {
  Future<void> urLauncher(String name) async {
    String url = "";
    if (name == "facebook") {
      url = "https://www.facebook.com/hima.yousef.7/";
    } else if (name == "instagram") {
      url = "";
    }
    if (await canLaunch("${url}")) {
      await launch(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

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
          'Contact us',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.color1),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(-3, 0),
                      blurRadius: 15,
                      color: Colors.grey.withOpacity(0.4),
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.color1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact info',
                      style: getTitleStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.w200),
                    ),
                    Gap(15),
                    Text(
                      'Stadium reservations can be made online.',
                      style: getTitleStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.w200),
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Icon(Icons.phone, color: AppColors.white),
                        Gap(10),
                        Text(
                          '+2100501111',
                          style: getTitleStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Gap(15),
                    Row(
                      children: [
                        Icon(Icons.mail, color: AppColors.white),
                        Gap(10),
                        Text(
                          'kimit.flutter@gmail.com',
                          style: getTitleStyle(
                              fontSize: 16,
                              color: AppColors.white,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Social media'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      urLauncher('facebook');
                    },
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                      color: Colors.blue[900],
                    ),
                  ),
                  Gap(10),
                  GestureDetector(
                    onTap: () {
                      urLauncher('');
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.redColor,
                      radius: 15,
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        size: 18,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      pushTo(context, more_inquiries());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color1,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "more inquiries ",
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
