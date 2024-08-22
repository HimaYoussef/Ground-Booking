import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Details_View.dart';
import 'package:pitch_test/features/customer/Home/main_view.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';

class Grounds_Specialists extends StatefulWidget {
  const Grounds_Specialists({
    super.key,
    required this.Type,
  });
  final String Type;

  @override
  State<Grounds_Specialists> createState() => _nameState();
}

class _nameState extends State<Grounds_Specialists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, Main_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          widget.Type,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.Type)
            .orderBy('price', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot Courts = snapshot.data!.docs[index];
                  if (Courts['name'] == null ||
                      Courts['image'] == null ||
                      Courts['price'] == null ||
                      Courts['description'] == null) {
                    return const SizedBox();
                  }
                  return Courts_details(
                      name: Courts['name'],
                      image: Courts['image'],
                      price: Courts['price'],
                      desc: Courts['description'],
                      rate: Courts['rate'],
                      rate_num: Courts['rate_num'],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => details_View(
                              id: Courts['id'],
                            ),
                          ),
                        );
                      });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 15);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
