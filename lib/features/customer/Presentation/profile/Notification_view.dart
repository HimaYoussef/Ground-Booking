import 'package:flutter/material.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/profile/profile_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/widgets/Custom_Notification_view.dart';

class Notification_view extends StatefulWidget {
  const Notification_view({super.key});

  @override
  State<Notification_view> createState() => _Notification_viewState();
}

class _Notification_viewState extends State<Notification_view> {
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
          'Notification',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          custom_Notification_view(
            Notification: 'Omar posted 1 post ',
          ),
          custom_Notification_view(
            Notification: 'Ali is looking for player in New cairo ',
          ),
          custom_Notification_view(
            Notification: 'Mahmoud  is looking for player in New cairo ',
          )
        ],
      ),
    );
  }
}
