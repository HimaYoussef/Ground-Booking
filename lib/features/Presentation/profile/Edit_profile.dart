import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Presentation/profile/Settings_view.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _displayoldPassword = TextEditingController();
  final TextEditingController _displayNewPassword = TextEditingController();

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pitch-e052f.appspot.com');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _imagePath;
  File? file;
  String? profileUrl;
  bool isVisable = true;

  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, Settings_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
          'Edit account ',
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
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
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                      width: 350,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 45,
                            backgroundImage: (_firebaseAuth
                                        .currentUser?.photoURL !=
                                    null)
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
                        GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.white,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
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
                    Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _displayName,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please Enter your name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(20),
                    TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: AppColors.black),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Current password',
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon((isVisable)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded)),
                      ),
                      controller: _displayoldPassword,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter Your password';
                        return null;
                      },
                    ),
                    Gap(20),
                    TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: AppColors.black),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon((isVisable)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded)),
                      ),
                      controller: _displayNewPassword,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter Your password';
                        return null;
                      },
                    ),
                    Gap(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                {
                                  FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(_displayName.text);

                                  FirebaseAuth.instance.currentUser!
                                      .updatePassword(_displayNewPassword.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Update Success'),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.color1,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "save change ",
                              style: getbodyStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
