import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/Presentation/profile/widgets/Api_notification.dart';
import 'package:pitch_test/features/Splash.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              snackBarTheme:
                  SnackBarThemeData(backgroundColor: AppColors.redColor),
              appBarTheme: AppBarTheme(
                  titleTextStyle: getTitleStyle(color: AppColors.white),
                  centerTitle: true,
                  elevation: 0.0,
                  actionsIconTheme: IconThemeData(color: AppColors.color1),
                  backgroundColor: AppColors.color1),
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: const EdgeInsets.only(
                    left: 20, top: 10, bottom: 10, right: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
                hintStyle: getbodyStyle(color: Colors.grey),
                fillColor: AppColors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.color2)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.color2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.color2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.redColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.redColor)),
                // filled: true,
                // suffixIconColor: AppColors.color1,
                // prefixIconColor: AppColors.color1,
                // fillColor: AppColors.scaffoldBG,
                // hintStyle: GoogleFonts.poppins(
                //   color: Colors.grey,
                //   fontSize: 14,
                // ),
              ),
              dividerTheme: DividerThemeData(
                color: AppColors.black,
                indent: 10,
                endIndent: 10,
              ),
              fontFamily: GoogleFonts.cairo().fontFamily),
          home: const SplashView(),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
