import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import localization packages
import 'package:pitch_test/LocalProvider.dart'; // Import your locale provider
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/Splash.dart';
import 'package:pitch_test/features/auth/presentation/view-model/auth_cubit.dart';
import 'package:pitch_test/features/customer/Presentation/profile/widgets/Api_notification.dart';
import 'package:pitch_test/features/customer/Presentation/profile/widgets/NotificationHelper.dart';
import 'package:pitch_test/firebase_options.dart';
import 'package:pitch_test/generated/l10n.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'your_channel_id', // id
  'your_channel_name', // name
  description: 'your_channel_description', // description
  importance: Importance.high,
);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  FirebaseMessaging.instance.requestPermission();
  NotificationHelper.init();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
          locale: localeProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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
              backgroundColor: AppColors.color1,
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                left: 20,
                top: 10,
                bottom: 10,
                right: 20,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none,
              ),
              hintStyle: getbodyStyle(color: Colors.grey),
              fillColor: AppColors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.color2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.color2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.color2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.redColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.redColor),
              ),
            ),
            dividerTheme: DividerThemeData(
              color: AppColors.black,
              indent: 10,
              endIndent: 10,
            ),
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
          home: const SplashView(),
          builder: (context, child) {
            return Directionality(
              textDirection: localeProvider.locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
