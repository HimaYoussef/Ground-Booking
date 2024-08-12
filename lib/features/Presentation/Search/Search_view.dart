import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Home/Widgets/Details_View.dart';
import 'package:pitch_test/features/Presentation/Search/Search_list.dart';
import 'package:pitch_test/features/Presentation/Search/widgets/Courts_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          ' Search ',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Container(
            // height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 15,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: TextField(
              onChanged: (searchKey) {
                setState(
                  () {
                    search = searchKey;
                    _length = search.length;
                  },
                );
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: getbodyStyle(),
                suffixIcon: SizedBox(
                    child: Icon(Icons.search, color: AppColors.color1)),
              ),
            ),
          ),
          Gap(20),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: _length == 0
                  ? StreamBuilder(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    var userData = snapshot.data!.docs[index];

                                    return Courts_details(
                                      name: userData['name'],
                                      image: userData['image'],
                                      price: userData['price'],
                                      desc: userData['description'],
                                      rate: userData['rate'],
                                      rate_num: userData['rate_num'],
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                details_View(),
                                          ),
                                        );
                                        ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.color1.withOpacity(1),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: AppColors.color2,
                                              )),
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 15);
                                  },
                                ),
                              );
                      })
                  : SearchList(
                      searchKey: search,
                    ),
            ),
          ),
        ]),
      ),
    );
  }
}
