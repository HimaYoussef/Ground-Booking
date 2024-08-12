import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/no_booking.dart';
import 'package:pitch_test/features/Presentation/booking/Find_Player.dart';

class Booking_view extends StatefulWidget {
  const Booking_view({super.key});

  @override
  State<Booking_view> createState() => _Booking_viewState();
}

class _Booking_viewState extends State<Booking_view> {
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
        .collection('pending')
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' My Bookings ',
                style: getbodyStyle(
                    fontSize: 20,
                    color: AppColors.color1,
                    fontWeight: FontWeight.w600),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .doc('appointments')
                    .collection('pending')
                    .where('UserID', isEqualTo: '${user!.email}')
                    .orderBy('StartHour', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data?.size == 0
                      ? const NoScheduledWidget()
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data?.size,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
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
                                    height: 300,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  '${document['image']}',
                                                  width: 150,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${document['Court']}',
                                                    style: getbodyStyle(
                                                        fontSize: 12,
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
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
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .calendar_month_rounded,
                                                              color: AppColors
                                                                  .color1,
                                                              size: 16),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            _dateFormatter(document[
                                                                    'StartHour']
                                                                .toDate()
                                                                .toString()),
                                                            style: getsmallStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                            height: 25,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .watch_later_outlined,
                                                              color: AppColors
                                                                  .color1,
                                                              size: 16),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            _timeFormatter(
                                                              document[
                                                                      'StartHour']
                                                                  .toDate()
                                                                  .toString(),
                                                            ),
                                                            style: getsmallStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .watch_later_outlined,
                                                              color: AppColors
                                                                  .color1,
                                                              size: 16),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const SizedBox(
                                                            height: 25,
                                                          ),
                                                          Text(
                                                            _timeFormatter(
                                                              document[
                                                                      'EndHour']
                                                                  .toDate()
                                                                  .toString(),
                                                            ),
                                                            style: getsmallStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${document['description']}',
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: getbodyStyle(
                                                      fontSize: 12,
                                                      color: AppColors.black),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    _documentID = document.id;
                                                    showAlertDialog(context,
                                                        document['UserID']);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: getsmallStyle(),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 45,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  pushTo(context,
                                                      Find_Player_view());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.color1,
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Find Players to join ",
                                                  style: getbodyStyle(
                                                      color: AppColors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
