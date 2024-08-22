import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/auth/presentation/View/sign_in_view.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:pitch_test/generated/l10n.dart';

class New_Password extends StatefulWidget {
  const New_Password({super.key});

  @override
  _New_PasswordState createState() => _New_PasswordState();
}

class _New_PasswordState extends State<New_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

  bool isVisable = true;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          pushAndRemoveUntil(context, LoginView());
        } else if (state is UpdateErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Logo.png',
                      width: MediaQuery.of(context).size.width,
                    ),
                    Gap(50),
                    Text(
                      S.of(context).New_Password_Head,
                      style: getTitleStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Gap(15),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                               S.of(context).New_Password_Desc,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          textAlign: TextAlign.start,
                          style: TextStyle(color: AppColors.black),
                          obscureText: isVisable,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText:  S.of(context).New_Password_Password,
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
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please Enter Your password';
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          style: TextStyle(color: AppColors.black),
                          obscureText: isVisable,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText:  S.of(context).New_Password_Confirm_new_password,
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
                          controller: _confirmpasswordController,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please confirm the New Password ';
                            if (_passwordController.text !=
                                _confirmpasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        Gap(20),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    // await context
                                    //     .read<AuthCubit>()
                                    //     .updatePassword(
                                    //         uid: user!.uid,
                                    //         password: _confirmpasswordController
                                    //             .text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Update Success'),
                                      ),
                                    );
                                    pushAndRemoveUntil(context, LoginView());
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: $e'),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.color1,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                 S.of(context).New_Password_Change_password_button,
                                style: getTitleStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
