import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Home/Widgets/Grounds_Specialists.dart';
import 'package:pitch_test/features/Home/data/Card_model.dart';
import 'package:pitch_test/features/auth/data/sports_Type.dart';

class Ground_View extends StatefulWidget {
  const Ground_View({super.key});

  @override
  State<Ground_View> createState() => _Ground_ViewState();
}

class _Ground_ViewState extends State<Ground_View> {
  List<CardModel> cards = [
    CardModel(Sport_Types[0], 'assets/football.png', 'Football'),
    CardModel(Sport_Types[1], 'assets/Padel.png', 'Padel'),
    CardModel(Sport_Types[2], 'assets/tennis.png', 'Tennis'),
    CardModel(Sport_Types[3], 'assets/basket.png', 'Basket'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sports", style: getTitleStyle(fontSize: 16)),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ListView.separated(
              itemCount: cards.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pushTo(
                      context,
                      Grounds_Specialists(Type: cards[index].name),
                    );
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        cards[index].Image,
                        height: 150,
                        fit: BoxFit.cover,
                      )),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
