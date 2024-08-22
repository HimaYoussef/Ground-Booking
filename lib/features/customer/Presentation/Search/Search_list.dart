import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Home/Widgets/Details_View.dart';
import 'package:pitch_test/features/customer/Presentation/Search/widgets/Courts_view.dart';

class SearchList extends StatefulWidget {
  final String searchKey;

  const SearchList({super.key, required this.searchKey});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Courts')
          .orderBy('name')
          .startAt([widget.searchKey]).endAt(
              ['${widget.searchKey}\uf8ff']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return snapshot.data?.size == 0
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              builder: (context) => details_View(),
                            ),
                          );
                        },);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 15);
                  },
                ),
              );
      },
    );
  }
}
