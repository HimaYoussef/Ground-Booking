import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';

class custom_Notification_view extends StatefulWidget {
  const custom_Notification_view({super.key, required this.Notification});
  final String Notification;

  @override
  State<custom_Notification_view> createState() => _Notification_viewState();
}

class _Notification_viewState extends State<custom_Notification_view> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 55,
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 12,
                      child: Icon(Icons.notifications_none,
                          size: 20, color: AppColors.color1)),
                  Gap(10),
                  Text(
                    widget.Notification,
                    style: getTitleStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
