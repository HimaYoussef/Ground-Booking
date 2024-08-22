import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/auth/presentation/View/sign_in_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/About_app.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Contact_us.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Last_order.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Notification_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Offers_group_view.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Settings_view.dart';
import 'package:pitch_test/generated/l10n.dart';

class profile_view extends StatefulWidget {
  const profile_view({super.key});

  @override
  State<profile_view> createState() => _nameState();
}

class _nameState extends State<profile_view> {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pitch-test-12b39.appspot.com');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _imagePath;
  File? file;
  String? profileUrl;

  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    print(user?.displayName);
    UserID = user?.uid;
  }
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  uploadImageToFireStore(File image, String imageName) async {
    Reference ref =
        _storage.ref().child('users/${_auth.currentUser!.uid}$imageName');
    SettableMetadata metadata = SettableMetadata(contentType: '');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!, 'doc');
    FirebaseFirestore.instance.collection('users').doc(UserID).set({
      'image': profileUrl,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data;
          return Stack(
            children: [
              Positioned(
                top: 60,
                child: Column(
                  children: [
                    Image.asset('assets/Background.png'),
                  ],
                ),
              ),
              Positioned(
                top: 60,
                right: 2,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.white,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 45,
                        backgroundImage:
                            (_firebaseAuth.currentUser?.photoURL != null)
                                ? NetworkImage(
                                    '${_firebaseAuth.currentUser?.photoURL}')
                                : (userData?['image'] != null)
                                    ? NetworkImage(userData?['image'])
                                    : (_imagePath != null)
                                        ? FileImage(File(_imagePath!))
                                            as ImageProvider
                                        : const AssetImage(
                                            'assets/OnBoarding2.png'),
                      ),
                    ),
                    Gap(15),
                    Text(
                      FirebaseAuth.instance.currentUser?.displayName ??
                          'No Name',
                      style: getbodyStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Gap(15),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? 'No Email',
                      style: getsmallStyle(
                        color: AppColors.black.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    ),
                    Gap(5),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, Last_order_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_Last_order_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, Offers_group_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_Offers_group_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, About_app_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_About_App_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, Notification_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_Notification_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, Contact_us_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_Contact_us_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pushTo(context, Settings_view());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.scaffoldBG.withOpacity(1),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).profile_view_Settings_button,
                              style: getbodyStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          GoogleSignIn googleSignIn = GoogleSignIn();
                          googleSignIn.disconnect();

                          pushAndRemoveUntil(context, LoginView());
                          _signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: AppColors.color2,
                              )),
                        ),
                        child: Text(
                          S.of(context).profile_view_log_out,
                          style: getbodyStyle(color: AppColors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/Graphic Elements.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
