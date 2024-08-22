import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/generated/l10n.dart';

class Help_view extends StatefulWidget {
  const Help_view({super.key});

  @override
  State<Help_view> createState() => _Help_viewState();
}

class _Help_viewState extends State<Help_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          S.of(context).Help_view_Help1,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
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
                         S.of(context).Help_view_Help2,
                        style: getTitleStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              ),
              Gap(15),
              Container(
                height: 70,
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
                         S.of(context).Help_view_Help3,
                        style: getTitleStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              ),
              Gap(15),
              Container(
                height: 93,
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
                         S.of(context).Help_view_Help4,
                        style: getTitleStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w200),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
