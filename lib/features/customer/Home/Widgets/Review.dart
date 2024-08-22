import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/Custom_button.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/customer/Home/data/Court_model.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';
import 'package:pitch_test/generated/l10n.dart';

class Review_view extends StatefulWidget {
  final Court courts;
  final String? id;

  const Review_view({
    Key? key,
    required this.courts,
    this.id,
  }) : super(key: key);

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<Review_view> {
  final _messageController = TextEditingController();
  int rate = 0;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1),
        ),
        centerTitle: false,
        title: Text(
          S.of(context).Review_head,
          style: getTitleStyle(
            fontSize: 20,
            color: AppColors.color1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Courts')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // var itemData = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Courts_details(
                    name: widget.courts.name,
                    image: widget.courts.imageUrl,
                    price: widget.courts.price,
                    desc: widget.courts.description,
                    rate: widget.courts.rate,
                    rate_num: widget.courts.rate_num,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: AppColors.scaffoldBG,
                    child: ExpansionTile(
                      collapsedIconColor: AppColors.color2,
                      backgroundColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(vertical: 0),
                      subtitle: Text(
                        S.of(context).Review_Share_Your_Feedback,
                        style: getsmallStyle(),
                      ),
                      title: Text(
                        S.of(context).Review_Text_Tile,
                        style: getTitleStyle(fontSize: 16),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _messageController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: S.of(context).Review_hintText,
                              fillColor: AppColors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        rate = index + 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(
                                        rate <= index
                                            ? Icons.star_border_purple500
                                            : Icons.star_purple500_sharp,
                                        color: AppColors.color1,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        CustomButton(
                          width: 90,
                          height: 40,
                          radius: 10,
                          text: S.of(context).Review_Send_button,
                          onTap: () {
                            String date =
                                DateFormat.yMMMMd().format(DateTime.now());
                            String time =
                                DateFormat('hh:mm:ss a').format(DateTime.now());

                            // updateCourtRate(
                            //   itemData!['name'],
                            //   itemData['rate_num'],
                            //   rate,
                            //   itemData['rate_sum'],
                            // );

                            _addToReport(
                              message: _messageController.text,
                              rate: rate,
                              time: time,
                              date: date,
                              userID: user!.uid,
                            );

                            _messageController.clear();

                            showErrorDialog(
                              context,
                              'Your Review sent Successfully',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // void updateCourtRate(String courtId, int rate, int rateNum, int oldRate) {
  //   FirebaseFirestore.instance.collection('Courts_rate').doc(courtId).set(
  //     {
  //       'rate_sum': oldRate + rate,
  //       'rate_num': (rateNum == 0) ? (rateNum + 2) : (rateNum + 1),
  //       'rate': ((oldRate + rate) ~/ (rateNum + 1) >= 5)
  //           ? 5
  //           : (oldRate + rate) ~/ (rateNum + 1),
  //     },
  //     SetOptions(merge: true),
  //   );
  // }

  void _addToReport({
    required String message,
    required int rate,
    required String time,
    required String date,
    required String userID,
  }) {
    FirebaseFirestore.instance.collection('reports-list').doc().set(
      {
        'message': message,
        'rate': rate,
        'time': time,
        'date': date,
        'id': userID,
      },
      SetOptions(merge: true),
    );
  }
}
