import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/auth/presentation/View/widgets/PIN_view.dart';
import 'package:pitch_test/features/auth/presentation/View/New_Password.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:pitch_test/generated/l10n.dart';

class Verification_view extends StatefulWidget {
  const Verification_view({Key? key, required this.myauth}) : super(key: key);
  final EmailOTP myauth;
  @override
  State<Verification_view> createState() => _Verification_viewState();
}

class _Verification_viewState extends State<Verification_view> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushAndRemoveUntil(context, const New_Password());
        } else if (state is LoginErrorState) {
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
                         S.of(context).Verification_code_Head,
                        style: getTitleStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      Gap(20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                               S.of(context).Verification_code_Desc,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Otp(
                                otpController: otp1Controller,
                              ),
                              Otp(
                                otpController: otp2Controller,
                              ),
                              Otp(
                                otpController: otp3Controller,
                              ),
                              Otp(
                                otpController: otp4Controller,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await EmailOTP.verifyOTP(
                                        otp: otp1Controller.text +
                                            otp2Controller.text +
                                            otp3Controller.text +
                                            otp4Controller.text) ==
                                    true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP is verified"),
                                  ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const New_Password()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Invalid OTP")));
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
                              "verify",
                              style: getTitleStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Didn\'t receive the OTP?',
                              style: getbodyStyle(color: AppColors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context)
                                  //     .pushReplacement(MaterialPageRoute(
                                  //   builder: (context) => (),
                                  // ));
                                },
                                child: Text(
                                  S.of(context).Verification_code_Resend_button,
                                  style: getbodyStyle(color: AppColors.color1),
                                ))
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
