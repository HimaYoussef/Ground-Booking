import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/functions/email_validation.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/customer/Presentation/profile/Contact_us.dart';
import 'package:pitch_test/generated/l10n.dart';

class more_inquiries extends StatefulWidget {
  const more_inquiries({super.key});

  @override
  State<more_inquiries> createState() => _more_inquiriesState();
}

class _more_inquiriesState extends State<more_inquiries> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _displaysubject = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _MessageController = TextEditingController();
  sendEmail(
    String _displaysubject,
    String _MessageController,
    String recipient,
    // String cc
  ) async {
    final Email email = Email(
      body: _MessageController,
      subject: _displaysubject,
      // cc: ['kimit.flutter@gmail.com'],
      recipients: [recipient],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Pop(context, Contact_us_view()),
            child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1)),
        centerTitle: false,
        title: Text(
         S.of(context).more_inquiries_head,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(50),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _displaysubject,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText:  S.of(context).more_inquiries_Subject,
                    label: Text('Enter your subject'),
                    labelStyle: getbodyStyle(color: AppColors.color2),
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText:  S.of(context).more_inquiries_Email,
                    label: Text('Contact : kimit.flutter@gmail.com'),
                    labelStyle: getbodyStyle(color: AppColors.color2),
                    hintStyle: getbodyStyle(color: Colors.grey),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Email';
                    } else if (!emailValidate(value)) {
                      return 'Please Enter A Valid Email';
                    } else {
                      return null;
                    }
                  },
                ),
                // Gap(20),
                // TextFormField(
                //   keyboardType: TextInputType.text,
                //   controller: _displaysubject,
                //   style: TextStyle(color: AppColors.black),
                //   decoration: InputDecoration(
                //     hintText: ' phone',
                //     label: Text('Enter Your phone number'),
                //     labelStyle: getbodyStyle(color: AppColors.color2),
                //     hintStyle: getbodyStyle(color: Colors.grey),
                //     fillColor: AppColors.white,
                //     filled: true,
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) return 'Please Enter a Phone Number';
                //     return null;
                //   },
                // ),
                Gap(20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _MessageController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText:  S.of(context).more_inquiries_Message,
                    label: Text('Write Your Message'),
                    labelStyle: getbodyStyle(color: AppColors.color2),
                    hintStyle: getbodyStyle(color: Colors.grey),
                    fillColor: AppColors.white,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please Enter your Message';
                    } else {
                      return null;
                    }
                  },
                ),
                Gap(15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          sendEmail(
                            _displayName.text,
                            _MessageController.text,
                            _emailController.text,
                          );
                          // clear the text field after send the mail
                          _displayName.clear();
                          _MessageController.clear();
                          _emailController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.color1,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                               S.of(context).more_inquiries_Submit_button,
                              style: getbodyStyle(color: AppColors.white),
                            ),
                            Gap(10),
                            Icon(Icons.arrow_forward, color: AppColors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
