
import 'dart:io';


import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/storage/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_autoupdate/flutter_autoupdate.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:version/version.dart';

class UpdationScreen extends StatefulWidget {
  const UpdationScreen({Key? key}) : super(key: key);

  @override
  State<UpdationScreen> createState() => _UpdationScreenState();
}

class _UpdationScreenState extends State<UpdationScreen> {
  UpdateResult? _result;
  DownloadProgress? _download;
  var _startTime = DateTime.now().millisecondsSinceEpoch;
  var _bytesPerSec = 0;
  var devid="",devName="",appVersion="";
  bool checkNewUpdation = true ;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),(){
      deviceInfo();
      fnCheckUpdate();
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 100, width: 100,
              child: Image.asset(
                AppAssets.tappLogo, fit: BoxFit.fill,)),
          gapHC(20),
          tc("version ${appVersion.toString()}", AppColors.lightfontcolor, 12),

          tc(devid.toString(), AppColors.lightfontcolor, 12),
          tc(devName.toString(), AppColors.lightfontcolor, 12),
          commonController.wstrSunmiDevice.value=="Y"?tc("Sunmi Version", AppColors.lightfontcolor, 12):tc("", AppColors.lightfontcolor, 12),
          gapHC(10),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Check For Update",
                onpressed: (){
                   dprint(_result?.latestVersion);
                  if(Version.parse(appVersion.toString()) < _result?.latestVersion){
                    showDialog(
                          context: context,
                          builder: (context) =>  AlertDialog(
                            content: Container(
                              height: 250,width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                     child: SingleChildScrollView(
                                       child: Column(
                                        children: [
                                          SizedBox(
                                              height: 60, width: 60,
                                              child: Image.asset(
                                                AppAssets.tappLogo, fit: BoxFit.fill,)),
                                          gapHC(8),
                                          tc("New version", AppColors.lightfontcolor, 12),
                                          gapHC(3),
                                          tc(_result?.latestVersion.toString()??"", AppColors.lightfontcolor, 12),
                                          gapHC(3),
                                          tc(_result?.releaseDate.toString()??"", AppColors.lightfontcolor, 12),
                                          gapHC(3),
                                          tc(_result?.releaseNotes.toString()??"", AppColors.lightfontcolor, 12),
                                          gapHC(3),





                                        ],
                                    ),
                                     ),
                                  ),

                                  CommonButton(buttoncolor:AppColors.primarycolor, icon_need: false,buttonText: "Download",
                                      onpressed: (){
                                        Get.back();
                                        fnDownload();

                                    // if(Version.parse(appVersion.toString()) < _result?.latestVersion){
                                    //
                                    // }
                                      },
                                      )
                                ],

                              ),
                            )

                          ));

                  }else{
                    dprint("noupdationfounf");
                    setState(() {
                      checkNewUpdation=false;
                    });

                  }


            },
                icon_need: false),
          ),


          gapHC(10),
          _download!=null ? tc("Progress: ${_download!.progress.toInt()}%", AppColors.lightfontcolor, 12):gapHC(0),
          gapHC(3),
          _download!=null ? tc("Speed: ${_download!.toPrettyMB(_bytesPerSec)}/s", AppColors.lightfontcolor, 12):gapHC(0),

          gapHC(3),
          checkNewUpdation==false ? tcn("No Update Available",AppColors.subcolor,12,TextAlign.center):SizedBox()






        ],

      ),
    );
  }





  Future<void> fnCheckUpdate() async {
    UpdateResult? result;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (Platform.isAndroid || Platform.isIOS) {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await Permission.storage.request();
      }
    }

    var versionUrl;
    if (Platform.isAndroid) {
      versionUrl ='https://beamserp.com/tapp/app_version.json';
    } else if (Platform.isWindows) {
      versionUrl ='https://beamserp.com/tapp/exe_version.json';
    }

    /// Android/Windows
    var manager = UpdateManager(versionUrl: versionUrl);
    /// iOS
    // var manager = UpdateManager(appId: 1500009417, countryCode: 'my');
    try {
      result = await manager.fetchUpdates();
      setState(() {
        _result = result;
      });

    } on Exception catch (e) {
      print(e);
    }
  }

  fnDownload()async{
    dprint("download..............");
    try {
      var controller = await _result?.initializeUpdate();
      controller?.stream.listen((event) async {
        setState(() {
          if (DateTime.now().millisecondsSinceEpoch - _startTime >= 1000) {
            _startTime = DateTime.now().millisecondsSinceEpoch;
            _bytesPerSec = event.receivedBytes - _bytesPerSec;
          }
          _download = event;
        });
        if (event.completed) {
          print("Downloaded completed");
          await controller.close();
          await _result?.runUpdate(event.path, autoExit: true);

        }
      });
    } on Exception catch (e) {
      dprint("catchee ${e}");
      print(e);
    }
  }
  void deviceInfo()async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    if(mounted){
      setState(() {
        appVersion = packageInfo.version;
        dprint("Apppversionnnnn..... ${appVersion}");
        String buildNumber = packageInfo.buildNumber;
        devid = Prefs.getString(AppStrings.deviceId)!;
        devName= Prefs.getString(AppStrings.phonmodel)!;
      });
    }

  }

}


