import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/Search/Search_list.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';

class Search_Category extends StatefulWidget {
  const Search_Category({super.key, required this.searchKey});
  final String searchKey;

  @override
  State<Search_Category> createState() => _nameState();
}

class _nameState extends State<Search_Category> {
  final TextEditingController _textController = TextEditingController();

  String search = '';
  int _length = 0;

  @override
  void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: _length == 0
              ? Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Courts')
                                      .orderBy('price')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return snapshot.data?.size == 0
                                        ? Center(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/no-search.png',
                                                    width: 250,
                                                  ),
                                                  Text(
                                                    'There\'s no name matching',
                                                    style: getbodyStyle(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Scrollbar(
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.size,
                                              itemBuilder: (context, index) {
                                                var userData =
                                                    snapshot.data!.docs[index];

                                                return Courts_details(
                                                  name: userData['name'],
                                                  image: userData['image'],
                                                  price: userData['price'],
                                                  desc: userData['description'],
                                                  rate: userData['rate'],
                                                  rate_num:
                                                      userData['rate_num'],
                                                  onPressed: () {
                                                    // setState(() {
                                                    //   _length = 1;
                                                    // });
                                                    ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .color1
                                                          .withOpacity(1),
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .color2,
                                                              )),
                                                    );
                                                  },
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(height: 15);
                                              },
                                            ),
                                          );
                                  });
                            },
                            child: Text('Price')),
                        TextButton(
                            onPressed: () {
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Courts')
                                      .orderBy('rate')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return snapshot.data?.size == 0
                                        ? Center(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/no-search.png',
                                                    width: 250,
                                                  ),
                                                  Text(
                                                    'There\'s no name matching',
                                                    style: getbodyStyle(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Scrollbar(
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.size,
                                              itemBuilder: (context, index) {
                                                var userData =
                                                    snapshot.data!.docs[index];

                                                return Courts_details(
                                                  name: userData['name'],
                                                  image: userData['image'],
                                                  price: userData['price'],
                                                  desc: userData['description'],
                                                  rate: userData['rate'],
                                                  rate_num:
                                                      userData['rate_num'],
                                                  onPressed: () {
                                                    // setState(() {
                                                    //   _length = 1;
                                                    // });
                                                    ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .color1
                                                          .withOpacity(1),
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .color2,
                                                              )),
                                                    );
                                                  },
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(height: 15);
                                              },
                                            ),
                                          );
                                  });
                            },
                            child: Text('rate'))
                      ],
                    ),
                  ],
                )
              : SearchList(searchKey: search)),
    );
  }
}
