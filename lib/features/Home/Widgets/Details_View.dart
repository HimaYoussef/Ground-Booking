import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/Home/Booking_court.dart';
import 'package:pitch_test/features/Home/Widgets/Review.dart';
import 'package:pitch_test/features/Home/data/Court_model.dart';

class details_View extends StatefulWidget {
  final String? id;

  const details_View({
    super.key,
    this.id,
  });

  @override
  State<details_View> createState() => _details_ViewState();
}

class _details_ViewState extends State<details_View> {
  bool click = true;
  late Court court;

  String date = DateFormat.yMd().format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          'Courts Details',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Courts')
            .where('id', isEqualTo: widget.id)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var userData = snapshot.data!.docs[index];
                    court = Court(
                        name: userData['name'],
                        imageUrl: userData['image'],
                        category: userData['category'],
                        rate: userData['rate'],
                        rate_num: userData['rate_num'],
                        description: userData['description'],
                        id: userData['id'],
                        price: userData['price'],
                        StartHour: userData['StartHour'],
                        EndHour: userData['EndHour']);

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    userData['image'],
                                    width: 400,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: () {
                                        _AddFavourite(
                                            Image: userData['image'],
                                            Price: userData['price'],
                                            Name: userData['name']);
                                        showErrorDialog(
                                          context,
                                          'Added To favourite successfully',
                                        );
                                        setState(
                                          () {
                                            click = !click;
                                          },
                                        );
                                      },
                                      icon: Icon(click
                                          ? Icons.favorite_border
                                          : Icons.favorite),
                                      iconSize: 20,
                                      color: click
                                          ? AppColors.redColor
                                          : AppColors.redColor),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Text(userData['name'],
                                    style: getTitleStyle(
                                        fontSize: 15,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                CircleAvatar(
                                  radius: 15,
                                  child: Icon(Icons.location_on),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Description',
                                style: getTitleStyle(
                                  fontSize: 10,
                                  color: AppColors.color1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pushTo(
                                      context,
                                      Review_view(
                                        courts: court,
                                      ));
                                },
                                child: Text(
                                  'Reviews',
                                  style: getTitleStyle(
                                    fontSize: 10,
                                    color: AppColors.color1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: userData['price'],
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
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              userData['description'],
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: getbodyStyle(
                                  fontSize: 12, color: AppColors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pushTo(
                                        context,
                                        BookingCourt(
                                          courts: court,
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.color1,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Booking",
                                    style: getbodyStyle(color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  _AddFavourite({
    required String Name,
    required String Image,
    required String Price,
  }) async {
    FirebaseFirestore.instance.collection('favourite_List').doc(user?.uid).set({
      Name: {
        'name': Name,
        'image': Image,
        'price': Price,
      }
    }, SetOptions(merge: true));
  }
}
