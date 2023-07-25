import 'dart:io' show Platform;

import 'package:beams_tapp/common_widgets/notificaationPopup.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:beams_tapp/view/login/views/login_screen.dart';
import 'package:beams_tapp/view/payment/controller/pending_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


import '../storage/preference.dart';


// ValueNotifier<bool> isUpdateNotification = ValueNotifier<bool>(false);

final CommonController commonController = Get.put(CommonController());
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  dprint("onBackgroundMessage...... ${message}");

}

const AndroidNotificationChannel channel = AndroidNotificationChannel("high_imp_channel", "high_imp_notification");
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


class NotificationService{

  final PendingController pendingController = Get.put(PendingController());
  init()async {

    await Firebase.initializeApp();
    ///callback fired when the clicking on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      dprint("Clicked Background Notification ............... ${message.data}");
      dprint("onMessage................ ${message}");
      // pendingController.fnPendingPayment();
      ///check the data has value....
      var date=DateTime.now();
      var expdate =DateTime.now();
      if(message.data.isNotEmpty){
        try{
          date = DateTime.parse(message.data["DATE"]);
          expdate = DateTime.parse(message.data["EXP_DATE"]);
        }catch(e){
              dprint(e.toString());
        }
        final notificationData =  NotificationDataModel(date, mfnDbl(message.data["AMOUNT"]), message.data["DOCNO"],message.data["DOCTYPE"],expdate);
        dprint("Notication................ ${notificationData}");
        if(commonController.wstrUserCode.value.isNotEmpty){
       //   Get.to(()=> HomeScreen(notificationDataModel: notificationData));
          wDisplayDialog(date,mfnDbl(message.data["AMOUNT"]), message.data["DOCNO"], expdate,message.data["DOCTYPE"]);
        }else{
         // Get.to(()=> LoginScreen(notificationDataModel: notificationData,));
          commonController.wNotificationDataModel.value = notificationData;

        }

      }else{
        dprint("Messaage Data is EMpttyyyyyyyyyy");
      }

    });

    /// Fired in when the user tap notification in Foreground State( Android only )
    void selectNotification(String? payload) async {
      dprint("Payloooood  ${payload}");
      if (payload != null) {
          //////Move to Page
      }
    }




    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
    const intilizationSettingAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');
    ///ios setup....
    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initialisationSetting = const InitializationSettings(
        android: intilizationSettingAndroid,
        // iOS: initializationSettingsIOS
    );
    //
    // flutterLocalNotificationsPlugin.initialize(initialisationSetting,onDidReceiveBackgroundNotificationResponse: selectNotification);
    await flutterLocalNotificationsPlugin.initialize(
      initialisationSetting,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotification;
            break;

          case NotificationResponseType.selectedNotificationAction:
            // TODO: Handle this case.
            break;
        }
      },

    );



    ///This Callback Fired  When App is in Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // setNotifiactionCount ();

      dprint("onMessageListen...........................................");
    //  pendingController.fnPendingPayment();
      ///shown local push notification only if platform is android.
      if(Platform.isAndroid){
        var date=DateTime.now();
        var expdate=DateTime.now();
        dprint("dataaaaaaaaasss ${message.data.toString()}");
        if(message.data.isNotEmpty){
          dprint("daattteeee  ${message.data["DATE"]}");
          try{
            date = DateTime.parse(message.data["DATE"]);
            expdate = DateTime.parse(message.data["EXP_DATE"]);
            dprint("date.,,,,,,. ${date.toString()}");
            wDisplayDialog(date,mfnDbl(message.data["AMOUNT"]), message.data["DOCNO"], expdate,message.data["DOCTYPE"]);
          }catch(e){
            dprint("date....error..... ${e.toString()}");
          }

        }else{
          dprint("Messaage Data is EMpttyyyyyyyyyy");
        }


      }
    });


    ///This Callback Fired when app is in Launch state
    FirebaseMessaging.instance.getInitialMessage().then((message)async {
      dprint("getInitialMessage..........................................");
      pendingController.fnPendingPayment();
      if (message != null) {
        dprint("getInitialMessage........... ${message.data.toString()}");
        var date=DateTime.now();
        var expdate=DateTime.now();
        if(message.data.isNotEmpty){
          try{
            date = DateTime.parse(message.data["DATE"]);
            expdate = DateTime.parse(message.data["EXP_DATE"]);
          }catch(e){
                dprint(e.toString());
          }

          final notificationData =  NotificationDataModel(date, mfnDbl(message.data["AMOUNT"]), message.data["DOCNO"],message.data["DOCTYPE"],expdate);

          // navigateToScreen(message.data["page"]);
          commonController.wNotificationDataModel.value = notificationData;
        }


      }
    });
    enableIOSNotifications();
  }





  ///For ios Setup.. foreground things(heads up)....
  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );
  }

  Future<String?> getFcmToken()async{
    return await FirebaseMessaging.instance.getToken();
  }

  deleteToken(){
    FirebaseMessaging.instance.deleteToken();
  }


}