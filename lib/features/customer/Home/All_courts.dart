import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Details_View.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';
import 'package:pitch_test/generated/l10n.dart';

class All_courts_view extends StatefulWidget {
  const All_courts_view({super.key});

  @override
  State<All_courts_view> createState() => _nameState();
}

class _nameState extends State<All_courts_view> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Courts')
          .orderBy(
            'price',
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).All_courts_Head,
                  style:
                      getbodyStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Gap(10),
                ListView.separated(
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
              ],
            ),
          );
        }
      },
    );
  }
}
