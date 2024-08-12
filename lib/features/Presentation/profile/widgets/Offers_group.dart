import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';

class Offers_view extends StatefulWidget {
  const Offers_view({
    super.key,
    required this.Head,
    required this.Body,
    required this.Percent,
  });
  final String Head;
  final String Body;
  final String Percent;

  @override
  State<Offers_view> createState() => _Offers_viewState();
}

class _Offers_viewState extends State<Offers_view> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.Head,
              style: getbodyStyle(
                  fontSize: 15,
                  color: AppColors.black,
                  fontWeight: FontWeight.w700),
            ),
            Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.Body,
                    style: getsmallStyle(
                      fontSize: 15,
                      color: AppColors.black,
                    ),
                  ),
                  TextSpan(
                    text: widget.Percent,
                    style: getsmallStyle(
                        fontSize: 15,
                        color: AppColors.color2,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
