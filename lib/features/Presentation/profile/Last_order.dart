import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/no_booking.dart';
import 'package:pitch_test/features/Home/Widgets/Review.dart';
import 'package:pitch_test/features/Home/data/Court_model.dart';
import 'package:pitch_test/features/Presentation/profile/profile_view.dart';

class Last_order_view extends StatefulWidget {
  const Last_order_view({
    super.key,
  });

  @override
  State<Last_order_view> createState() => _Last_order_viewState();
}

class _Last_order_viewState extends State<Last_order_view> {
  late Court court;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> deleteAppointment(
    String docID,
  ) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc('appointments')
        .collection('all')
        .doc(docID)
        .delete();
  }

  String _dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

  String _timeFormatter(String timestamp) {
    String formattedTime =
        DateFormat('hh:mm').format(DateTime.parse(timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context, String doctorID) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteAppointment(
          _documentID!,
        );
        Navigator.of(context).pop();
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Cancel Booking"),
          content:
              const Text("Are you sure you want to cancel this appointment?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
      },
    );
    // AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.success,
    //     showCloseIcon: true,
    //     title: 'Cancel Booking',
    //     desc: 'Are you sure you want to cancel this appointment?',
    //     btnOkOnPress: () {
    //       {
    //          deleteAppointment(
    //       _documentID!
    //          );
    //       }
    //     },
    //     btnCancelOnPress: () {
    //       Navigator.pop(context);
    //     }).show();
  }

  _checkDiff(DateTime date) {
    var diff = DateTime.now().difference(date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, profile_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          'Last order',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('appointments')
              .doc('appointments')
              .collection('all')
              .where('UserID', isEqualTo: '${user!.email}')
              .orderBy('StartHour', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: const NoScheduledWidget());
            }
            return snapshot.data?.size == 0
                ? Center(child: NoScheduledWidget())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.size,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      if (_checkDiff(document['StartHour'].toDate())) {
                        deleteAppointment(
                          document.id,
                        );
                      }
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(-3, 0),
                                      blurRadius: 15,
                                      color: Colors.grey.withOpacity(0.5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            '${document['image']}',
                                            width: 150,
                                            height: 112,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${document['Court']}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: getbodyStyle(
                                                          fontSize: 12,
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Spacer(),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                '${document['price']}',
                                                            style: getsmallStyle(
                                                                fontSize: 10,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          TextSpan(
                                                            text: 'EGP / H',
                                                            style: getsmallStyle(
                                                                fontSize: 10,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Last book',
                                                        style: getsmallStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                      Gap(10),
                                                      Text(
                                                        _dateFormatter(document[
                                                                'StartHour']
                                                            .toDate()
                                                            .toString()),
                                                        style: getsmallStyle(
                                                            fontSize: 10,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          // pushTo(
                                                          //     context,
                                                          //     Review_view(
                                                          //       courts: court,
                                                          //     ));
                                                        },
                                                        child: Text(
                                                          'Comment and rate',
                                                          style: getsmallStyle(
                                                              fontSize: 10,
                                                              color: AppColors
                                                                  .color2),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      TextButton(
                                                          onPressed: () {
                                                            _documentID =
                                                                document.id;
                                                            showAlertDialog(
                                                                context,
                                                                document[
                                                                    'UserID']);
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: getsmallStyle(
                                                                color: AppColors
                                                                    .color2),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
