import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/features/customer/Home/All_courts.dart';
import 'package:pitch_test/features/customer/Home/Ground_Type.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Header_view.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Sports_slider.dart';

class Main_view extends StatefulWidget {
  const Main_view({super.key});

  @override
  State<Main_view> createState() => _NewsViewState();
}

class _NewsViewState extends State<Main_view> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header_view(),
          NewsImageSlider(),
          Gap(10),
          Ground_View(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  All_courts_view(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
