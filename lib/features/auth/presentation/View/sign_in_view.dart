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
import 'package:pitch_test/features/Home/nav_bar.dart';
import 'package:pitch_test/features/auth/presentation/View/forget_password.dart';
import 'package:pitch_test/features/auth/presentation/View/register_view.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_states.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        await googleUser.authentication;

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    Gap(50),
                    Text(
                      'Login to Your Account',
                      style: getTitleStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: getbodyStyle(color: Colors.grey),
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please Enter your Email';
                        } else if (!emailValidate(value)) {
                          return 'please Enter A valid email';
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
                        hintText: 'Password',
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
                        else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(top: 5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const forget_passowrd()));
                        },
                        child: Text(
                          'Forget Password ?',
                          style: getsmallStyle(color: AppColors.color1),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context.read<AuthCubit>().login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
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
                            "Sign in",
                            style: getTitleStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Or Sign in with',
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
                                onTap: () async{
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
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t Have An Account ?',
                                  style: getbodyStyle(color: AppColors.black),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) => RegisterView(),
                                      ));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style:
                                          getbodyStyle(color: AppColors.color1),
                                    ))
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
