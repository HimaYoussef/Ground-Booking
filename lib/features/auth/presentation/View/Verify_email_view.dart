import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:pitch_test/features/customer/Home/nav_bar.dart';
import 'package:pitch_test/generated/l10n.dart';

class Verify_view extends StatefulWidget {
  const Verify_view({super.key});

  @override
  _Verify_ViewState createState() => _Verify_ViewState();
}

class _Verify_ViewState extends State<Verify_view> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Verify_emailController = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushAndRemoveUntil(context, const HomeView());
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
                    Gap(30),
                    Text(
                      S.of(context).Verify_email_Head,
                      style: getTitleStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    Gap(30),
                    Text(
                       S.of(context).Verify_email_Desc,
                      textAlign: TextAlign.center,
                      style: getbodyStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black),
                    ),
                    Gap(20),
                    // Container(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     height: 50,
                    //     child: ElevatedButton(
                    //       onPressed: () async {
                    //         await context
                    //             .read<AuthCubit>()
                    //             .Verify(_Verify_emailController.text);
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: AppColors.color1,
                    //         elevation: 2,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(151),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         "verify",
                    //         style: getTitleStyle(color: AppColors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Column(
                          children: [
                            AnimatedButton(
                              text: 'Verify ',
                              color: AppColors.color1,
                              pressEvent: () {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    showCloseIcon: true,
                                    title:  S.of(context).Verify_email_Verify_Dialog_title,
                                    desc:  S.of(context).Verify_email_Verify_Dialog_desc,
                                    btnOkOnPress: () {
                                      {
                                        context.read<AuthCubit>().Verify(
                                            _Verify_emailController.text);
                                        // pushAndRemoveUntil(
                                        //     context, const HomeView());
                                      }
                                    }).show();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
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
