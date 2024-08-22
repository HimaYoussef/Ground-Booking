import 'package:flutter/material.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/profile/profile_view.dart';
import 'package:pitch_test/generated/l10n.dart';

class About_app_view extends StatefulWidget {
  const About_app_view({super.key});

  @override
  State<About_app_view> createState() => _About_app_viewState();
}

class _About_app_viewState extends State<About_app_view> {
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
          S.of(context).About_app_head,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.color2),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(-3, 0),
                  blurRadius: 15,
                  color: Colors.grey.withOpacity(0.4),
                )
              ],
              borderRadius: BorderRadius.circular(15),
              color: AppColors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   S.of(context).About_app_desc,
                  style: getTitleStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
