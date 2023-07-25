import 'package:beams_tapp/common_widgets/commonToast.dart';
import 'package:beams_tapp/common_widgets/commonbutton.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/constants/dateformates.dart';
import 'package:beams_tapp/constants/enums/toast_type.dart';
import 'package:beams_tapp/constants/string_constant.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/model/commonModel.dart';
import 'package:beams_tapp/model/notification_DataModel.dart';
import 'package:beams_tapp/notification/notification.dart';
import 'package:beams_tapp/servieces/api_repository.dart';
import 'package:beams_tapp/view/home/views/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceRegScreen extends StatefulWidget {
  final String ?deviceName;
  final String? deviceId;
  final String? companyCode;

  const DeviceRegScreen({Key? key, required this.deviceName, required this.deviceId, this.companyCode}) : super(key: key);
  @override
  State<DeviceRegScreen> createState() => _DeviceRegScreenState();
}
class _DeviceRegScreenState extends State<DeviceRegScreen> {
  NotificationService notificationService = NotificationService();
  ApiRepository apiRepository =ApiRepository();
  late Future<dynamic> futureFrom;
  TextEditingController txtDeviceName = TextEditingController();

@override
  void initState() {
   txtDeviceName.text = widget.deviceName.toString();
  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        title: tsw("Activation",AppColors.white,20,FontWeight.w500),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration:  commonBoxDecoration(AppColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

            margin: const EdgeInsets.symmetric(horizontal: 50),

            child: Material(
            elevation: 35.0,
            borderRadius: BorderRadius.circular(20) ,
            shadowColor: AppColors.lightfontcolor.withOpacity(0.17),
            child: TextFormField(
              autofocus: false,
              controller: txtDeviceName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.lightfontcolor, fontSize: 12,
               ),
              decoration: const InputDecoration(
                hintText: "DeviceName",
                fillColor: Colors.white,
                hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                errorStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),

              ),
              // validator: (String? value) {
              //   return FormValidator.isValid(textFormFieldType, value ?? "",paymentEnable);
              // },
            ),
             ),
          ),
            gapHC(10),
            tc(widget.deviceId, AppColors.lightfontcolor, 12),
            gapHC(2),
            tc(setDate(2, DateTime.now()), AppColors.lightfontcolor, 12),

            gapHC(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: CommonButton(buttoncolor: AppColors.primarycolor, buttonText: "Tap For Device Registration", onpressed: (){
               if(txtDeviceName.text.isNotEmpty){
                 fnRegisterDevice();
               }else{
                 Get.showSnackbar(
                   const GetSnackBar(
                     message: 'Please Enter DeviceName',
                     duration: Duration(seconds: 2),
                   ),
                 );
               }


              }, icon_need: false,),
            )
          ],
        ),
      ),
    );
  }

  /////////Function====================================================

 fnRegisterDevice()async{
    String? fcmToken = await notificationService.getFcmToken();
    var devId = widget.deviceId;
    var devName = txtDeviceName.text.toString();
    dprint(fcmToken.toString());
    dprint(devId);
    final responseJson = await apiRepository.apiRegstrDevice(devId,devName,fcmToken,widget.companyCode,setDate(2, DateTime.now()),"A");
    dprint(responseJson);
    CommonModel commonModel = CommonModel.fromJson(responseJson[0]);
    if(commonModel.sTATUS=="1"){
      CustomToast.showToast(
          "Device Registration Successfully..", ToastType.success, ToastPositionType.end);
      Get.offAll( HomeScreen(notificationDataModel: NotificationDataModel(DateTime.now(), 0.0, "","",DateTime.now())));
    }else{
      CustomToast.showToast(
          commonModel.mSG.toString(), ToastType.success, ToastPositionType.end);
    }

 }





}
