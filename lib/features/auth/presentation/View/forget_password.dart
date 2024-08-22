import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/email_validation.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/auth/presentation/View/Verification_code.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:pitch_test/generated/l10n.dart';

class forget_passowrd extends StatefulWidget {
  const forget_passowrd({super.key});

  @override
  _Forget_passwordState createState() => _Forget_passwordState();
}

class _Forget_passwordState extends State<forget_passowrd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _Forgrt_PasswordController =
      TextEditingController();
  EmailOTP myauth = EmailOTP();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushAndRemoveUntil(context, Verification_view(myauth: myauth));
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
          showErrorDialog(
            context,
            state.error,
          );
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
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
                    // Gap(30),
                    Text(
                      S.of(context).forget_password_Head,
                      style: getTitleStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Gap(20),
                    Text(
                      S.of(context).forget_password_Desc,
                      style: getbodyStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    Gap(20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _Forgrt_PasswordController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: S.of(context).forget_password_Email,
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please Enter your Email to reset your password';
                        } else if (!emailValidate(value)) {
                          return ' the email is Invalid please Enter A valid email';
                        } else {
                          return null;
                        }
                      },
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
                            // if (_formKey.currentState!.validate()) {
                            //   await context
                            //       .read<AuthCubit>()
                            //       .reset(_Forgrt_PasswordController.text);
                            // }
                            if (_formKey.currentState!.validate()) {
                              EmailOTP.config(
                                  appName: "Email OTP",
                                  appEmail: _Forgrt_PasswordController.text,
                                  otpLength: 4,
                                  otpType: OTPType.numeric);
                              if (await EmailOTP.sendOTP(
                                  email: _Forgrt_PasswordController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("OTP has been sent")));
                                pushAndRemoveUntil(
                                    context, Verification_view(myauth: myauth));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("OTP failed sent")));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.color1,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(151),
                            ),
                          ),
                          child: Text(
                            S.of(context).forget_password_Reset_password_button,
                            style: getTitleStyle(color: AppColors.white),
                          ),
                        ),
                      ),
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
