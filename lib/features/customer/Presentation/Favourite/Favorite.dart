import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Details_View.dart';
import 'package:pitch_test/generated/l10n.dart';

class Favourite_view extends StatefulWidget {
  const Favourite_view({super.key});

  @override
  State<Favourite_view> createState() => _nameState();
}

class _nameState extends State<Favourite_view> {
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  User? user;
  String? UserID;
  bool click = true;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          S.of(context).Favorite_head,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('favourite_List')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data?.data() as Map<String, dynamic>?;

                if (data == null || data.isEmpty) {
                  return Center(
                    child: Image.asset(
                      'assets/Empty-amico.png',
                      width: 250,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemCount: snapshot.data!.data()!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data!.data()!;
                        List<String> key = snapshot.data!.data()!.keys.toList();
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => details_View(
                                  id: item[key[index]]['name'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 120,
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
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          item[key[index]]['image'],
                                          width: 120,
                                          height: 100,
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
                                                    item[key[index]]['name'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: getbodyStyle(
                                                        fontSize: 12,
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: item[key[index]]
                                                              ['price'],
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
                                            Row(
                                              children: [
                                                Text(
                                                  S.of(context).Favorite_Comment_and_rate,
                                                  style: getsmallStyle(
                                                      fontSize: 10,
                                                      color: AppColors.color2),
                                                ),
                                                Spacer(),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          deleteItemFromFav(
                                                              item[key[index]]
                                                                  ['name']);
                                                          showErrorDialog(
                                                            context,
                                                            'Removed from your favourite successfully',
                                                          );
                                                          setState(
                                                            () {
                                                              click = !click;
                                                            },
                                                          );
                                                        },
                                                        icon: Icon(click
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border),
                                                        iconSize: 20,
                                                        color: click
                                                            ? AppColors.redColor
                                                            : AppColors
                                                                .redColor),
                                                  ],
                                                ),
                                                const Gap(10)
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
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gap(15),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }

  deleteItemFromFav(item) {
    FirebaseFirestore.instance.collection('favourite_List').doc(user?.uid).set({
      item: FieldValue.delete(),
    }, SetOptions(merge: true));
  }
}
