import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pitch_test/core/utils/Colors.dart';
import 'package:pitch_test/core/utils/Style.dart';
import 'package:pitch_test/features/auth/data/Hour_book.dart';
import 'package:pitch_test/features/customer/Presentation/profile/widgets/constants.dart';
import 'package:pitch_test/generated/l10n.dart';
import 'package:pitch_test/main.dart';

class Find_Player_view extends StatefulWidget {
  const Find_Player_view({super.key});

  @override
  State<Find_Player_view> createState() => _Find_Player_viewState();
}

class _Find_Player_viewState extends State<Find_Player_view> {
  String accessToken = '';

  late TextEditingController _textToken;
  late TextEditingController _textSetToken;
  late TextEditingController _textTitle;
  late TextEditingController _textBody;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    getAccessToken();

    // Initialize text controllers
    _textToken = TextEditingController();
    _textSetToken = TextEditingController();
    _textTitle = TextEditingController();
    _textBody = TextEditingController();

    // Initialize local notifications
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          debugPrint('notification payload: ${response.payload}');
        }
      },
    );

    // Listen to Firebase messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'your_channel_id',
              'your_channel_name',
              channelDescription: 'your_channel_description',
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    // Get the FCM token when the widget is initialized
    _getToken();
  }

  Future<void> getAccessToken() async {
    try {
      final serviceAccountJson = await rootBundle.loadString(
          'assets/pitch-test-12b39-firebase-adminsdk-nlp0t-f18f67a0d2.json');

      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson),
      );

      const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = http.Client();
      try {
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        setState(() {
          accessToken = accessCredentials.accessToken.data;
        });

        print('Access Token: $accessToken');
      } catch (e) {
        print('Error obtaining access token: $e');
      } finally {
        client.close();
      }
    } catch (e) {
      print('Error loading service account JSON: $e');
    }
  }

  Future<void> _getToken() async {
    _textToken.text = await FirebaseMessaging.instance.getToken() ?? "";
  }

  String _hourBook = Hour_book[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.color1),
        ),
        centerTitle: false,
        title: Text(
          S.of(context).Find_Player_head,
          style: getTitleStyle(
              fontSize: 20,
              color: AppColors.color1,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).Find_Player_How_Long_the_game,
                  style: getbodyStyle(
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                decoration: BoxDecoration(
                    color: AppColors.scaffoldBG,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  isExpanded: true,
                  iconEnabledColor: AppColors.color1,
                  icon: const Icon(Icons.expand_circle_down_outlined),
                  value: _hourBook,
                  onChanged: (String? newValue) {
                    setState(() {
                      _hourBook = newValue ?? Hour_book[0];
                    });
                  },
                  items: Hour_book.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textToken,
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: "My Token for this Device"),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _textToken.text));
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              TextField(
                controller: _textTitle,
                decoration: InputDecoration(labelText: "Enter Title"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _textBody,
                decoration: InputDecoration(labelText: "Enter Body"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _textSetToken,
                decoration: InputDecoration(labelText: "Enter Token"),
              ),
              Gap(25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (check()) {
                        pushNotificationsGroupDevice(
                          title: _textTitle.text,
                          body: _textBody.text,
                          token: _textSetToken.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color1,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      S.of(context).Find_Player_Find_Players_button,
                      style: getbodyStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (check()) {
                    pushNotificationsAllUsers(
                      title: _textTitle.text,
                      body: _textBody.text,
                    );
                  }
                },
                child: Text(
                  "Send notification for all users",
                  style: getbodyStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Send notification to all users
  void pushNotificationsAllUsers({
    required String title,
    required String body,
  }) async {
    try {
      final url = Uri.parse(Constants.BASE_URL);
      final headers = {
        'Authorization': Constants.ACCESS_TOKEN,
        'Content-Type': 'application/json',
      };

      String bodyData = json.encode({
        "message": {
          "topic": "all",
          "notification": {
            "title": title,
            "body": body,
          },
          "android": {
            "priority": "high",
          },
          "apns": {
            "headers": {"apns-priority": "10"},
            "payload": {
              "aps": {
                "sound": "default",
              },
            },
          },
        },
      });

      final response = await http.post(url, headers: headers, body: bodyData);

      if (response.statusCode == 200) {
        print("Notification sent to all users");
      } else {
        print("Failed to send notification: ${response.body}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  Future<bool> pushNotificationsGroupDevice({
    required String title,
    required String body,
    required String token,
  }) async {
    String bodyData = json.encode(
      {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "android": {
            "priority": "high",
          },
          "apns": {
            "headers": {"apns-priority": "10"},
            "payload": {
              "aps": {
                "sound": "default",
              },
            },
          },
        },
      },
    );
    var response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Authorization': Constants.ACCESS_TOKEN,
        'Content-Type': 'application/json',
        'project_id': "${Constants.SENDER_ID}"
      },
      body: bodyData,
    );

    print(response.body.toString());

    return true;
  }

  bool check() {
    if (_textTitle.text.isNotEmpty && _textBody.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Get FCM token
  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }
}
