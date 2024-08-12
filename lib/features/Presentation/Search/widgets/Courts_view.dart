import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';

class Courts_details extends StatelessWidget {
  const Courts_details(
      {super.key,
      required this.name,
      required this.image,
      required this.price,
      required this.desc,
      this.onPressed,
      required this.rate,
      required this.rate_num});

  final String name;
  final String image;
  final String price;
  final String desc;
  final int rate;
  final int rate_num;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: const Offset(-3, 0),
            blurRadius: 15,
            color: Colors.grey.withOpacity(0.5),
          )
        ], borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                width: 130,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: getbodyStyle(
                              fontSize: 12,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: price,
                                style: getsmallStyle(
                                    fontSize: 10,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: 'EGP / H',
                                style: getsmallStyle(
                                    fontSize: 10,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getbodyStyle(
                          fontSize: 12,
                          color: AppColors.black.withOpacity(0.5)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_sharp,
                          color: AppColors.color2,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${rate}${[rate_num]}',
                          style: getbodyStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 11),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
