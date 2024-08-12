import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //create an instance of firebase Message
  final _firebaseMessaging = FirebaseMessaging.instance;

  //Function to initialize notification
  Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //Fetch the FCM token for the device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the FCM token (for testing purposes)
    print('Token: $fCMToken');
  }

  //function to handle received messages

  //function to initialize foreground and background settings
}
