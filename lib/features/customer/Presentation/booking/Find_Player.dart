import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/auth/data/Hour_book.dart';
import 'package:pitch_test/generated/l10n.dart';

class Find_Player_view extends StatefulWidget {
  const Find_Player_view({super.key});

  @override
  State<Find_Player_view> createState() => _Find_Player_viewState();
}

class _Find_Player_viewState extends State<Find_Player_view> {
  String date = DateFormat.yMMMEd().format(DateTime.now());
  final TextEditingController _Players = TextEditingController();
  final TextEditingController _Comments = TextEditingController();

  String _Hour_book = Hour_book[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          S.of(context).Find_Player_head,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                     S.of(context).Find_Player_When_is_the_game_starting,
                      style: getbodyStyle(
                          color: AppColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.scaffoldBG,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: getsmallStyle(color: Colors.grey),
                    hintText: date,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.color1,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).Find_Player_How_Long_the_game,
                  style: getbodyStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                    color: AppColors.scaffoldBG,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  isExpanded: true,
                  iconEnabledColor: AppColors.color1,
                  icon: const Icon(Icons.expand_circle_down_outlined),
                  value: _Hour_book,
                  onChanged: (String? newValue) {
                    setState(() {
                      _Hour_book = newValue ?? Hour_book[0];
                    });
                  },
                  items: Hour_book.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).Find_Player_Number_of_players_needed,
                  style: getbodyStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.scaffoldBG,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _Players,
                  style: TextStyle(color: AppColors.black),
                  decoration: const InputDecoration(
                    hintText: 'Enter Number of players',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Number of players';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).Find_Player_Comments,
                  style: getbodyStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.scaffoldBG,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _Comments,
                  style: TextStyle(color: AppColors.black),
                  decoration:  InputDecoration(
                    hintText:  S.of(context).Find_Player_Write_your_comment,
                  ),
                ),
              ),
              Gap(25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color1,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                         S.of(context).Find_Player_Find_Players_button,
                        style: getbodyStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDateDialog() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      firstDate: DateTime(2023),
      initialDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (datePicked != null) {
      setState(() {
        date = DateFormat.yMd().format(datePicked);
      });
    }
  }
}
