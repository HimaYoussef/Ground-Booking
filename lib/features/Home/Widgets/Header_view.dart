import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Presentation/profile/Test_view.dart';

class Header_view extends StatelessWidget {
  const Header_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 80),
        Gap(20),
        CircleAvatar(
          radius: 10,
          backgroundColor: AppColors.color1,
          backgroundImage: const AssetImage('assets/sport icon.png'),
        ),
        Gap(20),
        Text(
          'welcome',
          style: getTitleStyle(fontSize: 15),
        ),
        Gap(15),
        Lottie.asset('assets/WaveHand.json', height: 30),
        Spacer(),
        // IconButton(
        //     onPressed: () {
        //       //       FirebaseFirestore.instance.collection('Padel').doc('UPadel').set({
        //       //         'id': 'UPadel',
        //       //         'name': 'UPadel',
        //       //         'image':
        //       //             '',
        //       //         'category': 'padel Court',
        //       //         'description':
        //       //             'UPadel is a fantastic place to begin training. For those living in Heliopolis and Nasr City, finding nearby places with padel courts can be challenging.',
        //       //         'price': '300',
        //       //         // 'is_offer': true,
        //       //         'rate': 4,
        //       //         // 'rate_num': 0,
        //       //         // 'rate_Sum': 4,
        //       //       });
        //       //       SetOptions(merge: true);
        //     },
        //     icon: Icon(
        //       Icons.filter_list,
        //       color: AppColors.color1,
        //       size: 30,
        //     ))
      ],
    );
  }
}
