import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pitch_test/core/functions/email_validation.dart';
import 'package:pitch_test/core/functions/routing.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/core/widgets/custom_dialogs.dart';
import 'package:pitch_test/features/auth/presentation/View/Verify_email_view.dart';
import 'package:pitch_test/features/auth/presentation/View/sign_in_view.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:pitch_test/features/customer/Home/nav_bar.dart';
import 'package:pitch_test/generated/l10n.dart';
import 'package:twitter_login/twitter_login.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

//------------------------------------ google login------------------------------//

class _RegisterViewState extends State<RegisterView> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //------------------------------------ facebook login------------------------------//

  String userEmail = "";

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile', 'user_birthday']);

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    final userData = await FacebookAuth.instance.getUserData();

    userEmail = userData['email'];

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  //------------------------------------ Twitter login------------------------------//

  Future signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'b6KFmj44VmkWsziit1FLb0JnA',
        apiSecretKey: 'X0N2SdeqNPrBpvmZhpW715AzA8zF9DE3RmCOcx7g5utUfdX7Tl',
        redirectURI: 'flutter-twitter-practice://');

    // Trigger the sign-in flow
    await twitterLogin.login().then((value) async {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: value.authToken!,
        secret: value.authTokenSecret!,
      );

      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _displayPhone = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          pushAndRemoveUntil(context, const Verify_view());
        } else if (state is RegisterErrorState) {
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
                    const SizedBox(height: 15),
                    Text(
                       S.of(context).register_Head,
                      style: getTitleStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _displayName,
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: S.of(context).register_Username,
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Please Enter a Name';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _displayPhone,
                      style: TextStyle(color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: S.of(context).register_Phone,
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please Enter a Phone Number';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: S.of(context).register_Email,
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
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: AppColors.black),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: S.of(context).register_Password,
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
                        if (value!.isEmpty) return 'Please Enter a password';
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              {
                                context.read<AuthCubit>().registerUser(
                                    _displayName.text,
                                    _displayPhone.text,
                                    _emailController.text,
                                    _passwordController.text);
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
                            S.of(context).register_Sign_Up_button,
                            style: getTitleStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).register_Sign_in_with_button,
                            style: getbodyStyle(color: AppColors.black),
                          ),
                          Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await signInWithTwitter();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 15,
                                  child: Icon(
                                    FontAwesomeIcons.twitter,
                                    size: 20,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              Gap(20),
                              GestureDetector(
                                onTap: () async {
                                  await signInWithGoogle();
                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeView(),
                                      ),
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.redColor,
                                  radius: 15,
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              Gap(20),
                              GestureDetector(
                                onTap: () async {
                                  await signInWithFacebook();
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ));
                                },
                                child: Icon(
                                  FontAwesomeIcons.facebook,
                                  size: 30,
                                  color: Colors.blue[900],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).register_Already_Have_An_Account_button,
                                  style: getbodyStyle(color: AppColors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => LoginView(),
                                    ));
                                  },
                                  child: Text(
                                   S.of(context).register_Sign_in_button,
                                    style:
                                        getbodyStyle(color: AppColors.color1),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
