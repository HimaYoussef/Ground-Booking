import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationsHelper {
  // creat instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  // Future<void> initNotifications() async {
  //   await _firebaseMessaging.requestPermission();
  //   // get device token
  //   String? deviceToken = await _firebaseMessaging.getToken();
  //   DeviceToken = deviceToken;
  //   print(
  //       "===================Device FirebaseMessaging Token====================");
  //   print(deviceToken);
  //   print(
  //       "===================Device FirebaseMessaging Token====================");
  // }

  // handle notifications when received
  // void handleMessages(RemoteMessage? message) {
  //   if (message != null) {
  //     // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
  //     showToast(
  //         text: 'on Background Message notification',
  //         state: ToastStates.SUCCESS);
  //   }
  // }

  // handel notifications in case app is terminated
  // void handleBackgroundNotifications() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  // }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "pitch-test-12b39",
      "private_key_id": "d3a45cb86ff992510d2a78d8df10a72681846bb7",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCgdTcGDatylb1d\n87I3AYc7XpZquK82Nq2BAyoeNh6N+n4KH4XQPVnSAhFCyzTIo+fxtn/bs5M1GQw+\nT6yW4E7SXHYuXG2gwR7WxlfnmCbu1/mngAkwYc6Hxu35bIZWZjU9Xq/pkPowc+vQ\nWFLKBAIVKgojwCNc7L3Sxc8MzqX1OhnoJ46ba8NIeHKgE6Jldb7DfVcP9U4mNTMk\nIfyCrFPXf9VCxx1weziEGEgkWlhL7RX1fYAa/w8F4wVMEHhlngUabQHw7glvKCwR\newpANB4EhtB3g/mEJ3QTzyqdSuC3MTZAag9oGdw3qFwLr4SyNlo3JGKK1ck9UpAF\niwPedeeTAgMBAAECggEABUlR/+3jsqQ9TMLydv54D/GB/3pzMf7jgNHJCZ1wge6j\n8r3EIQQMbq9TwJbE9+vygH5UlblDsHxRRhzw4OL7UHyXBi2pt6H1MU/v5c5CUMcm\nef7CuWiCL0CovCQiWZFc0AH2cLmujHnH5fbVpMM0tbF2C7nQ+xxE9WnqnuTmByoO\np+H52nHvbu6kyEkyyYx6aWshTJWJxvWvOq9f+FkXd2ZhhtItI9JztnzvtGIlUjTm\nvt5/8+ReeI5XCI458oR2dTiQTe5pVqhAMIo7TF85ee8WF1F6P4XkwLyQ+q7Ezj8J\n0iICoBIm/mSRRxq8i8ru9V8Id+K23xgkRvW7FxmbpQKBgQDZF28U7Vwe8T+mi+80\nmzSbdSQ03nARTgNtIyEbzYzE4pVGiDBYc93WnIhAAwwcxBpejVqA7OfpVT/dxdda\nvH9qlhGycO6S4UHnsmsbbVp8IrV5wmJlfKrij/8Ea1MDYsqursxfaRJVGzE/5tGL\n3i2EV/lA3CEYr/yPODOAmKbXnQKBgQC9N1KFhqTPaj4HMPm3oFSMMDpXIHJc5YmW\nYFYlhwOjh1JZeDVak1asqppYASckMN6PCwjf30QtqZXdVdFuWq4g6FfjkU1tOBaA\nWaMrW7C51UMjPgFmYca3qEsD9bpZ0gSghqs2dU3KCQ2RSO2+MdxdIyBmmQG0yKfy\nPwY2FnBM7wKBgQDDizArkYIg/P1wbyuQHx1LykBKvvIDJFpBvBreiE/8KHx9g77I\nbdWssmKoBhaq8pkuAfU7nClpK7jTcpmAybmbsIFQUhkThINwyG1hzyZqGnmMq2Mm\nNx1V5o621FV5/0rB/gFpD6PLtSqvfKHTctVdGEEUAzRsoFjGSMFbXCUsoQKBgA02\nL6zjGd7hrDMUWFtZ9o1TUL+EpHeYD2NQlrNIGhjw+e8FVbRdVU/5GY3LhtAgGWoj\nexsmm7wUe0JZG6Z47m+dyYU6QA3APNH5cEs2u8A+A9ISIkbjzNxGA/bi0YA0Cd6r\niIjk5+mTeD8MuIzvLlPSgBCp3lShLhjcDbL5Hh5BAoGBAIxKGcof5IlTrNoK6lmr\n2DDyutfgM6EEzGP2cKyvkFoJdNxc7TGYH4fz+5JzJ9CsivhZuiYRtn0CxsKRZ8dK\nZdZ1/7yab8bee0QpiCiNnKyHUUmIdZIIXHdNem+V9CPYMboW26I9POGGHCBBHFOd\ni9Z8eqPTn2+qKnok6e+TCHDb\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-nlp0t@pitch-test-12b39.iam.gserviceaccount.com",
      "client_id": "108093010196393702536",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-nlp0t%40pitch-test-12b39.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  // Map<String, dynamic> getBody({
  //   required String fcmToken,
  //   required String title,
  //   required String body,
  //   required String userId,
  //   String? type,
  // }) {
  //   return {
  //     "message": {
  //       "token": fcmToken,
  //       "notification": {"title": title, "body": body},
  //       "android": {
  //         "notification": {
  //           "notification_priority": "PRIORITY_MAX",
  //           "sound": "default"
  //         }
  //       },
  //       "apns": {
  //         "payload": {
  //           "aps": {"content_available": true}
  //         }
  //       },
  //       "data": {
  //         "type": type,
  //         "id": userId,
  //         "click_action": "FLUTTER_NOTIFICATION_CLICK"
  //       }
  //     }
  //   };
  // }

  // Future<void> sendNotifications({
  //   required String fcmToken,
  //   required String title,
  //   required String body,
  //   required String userId,
  //   String? type,
  // }) async {
  //   try {
  //     var serverKeyAuthorization = await getAccessToken();

  //     // change your project id
  //     const String urlEndPoint =
  //         "https://fcm.googleapis.com/v1/projects/(YourProjectId)/messages:send";

  //     Dio dio = Dio();
  //     dio.options.headers['Content-Type'] = 'application/json';
  //     dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

  //     var response = await dio.post(
  //       urlEndPoint,
  //       data: getBody(
  //         userId: userId,
  //         fcmToken: fcmToken,
  //         title: title,
  //         body: body,
  //         type: type ?? "message",
  //       ),
  //     );

  //     // Print response status code and body for debugging
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Data: ${response.data}');
  //   } catch (e) {
  //     print("Error sending notification: $e");
  //   }
  // }
}
