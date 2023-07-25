
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/title_withUnderline.dart';
import '../../../../constants/color_code.dart';
import '../../../../constants/styles.dart';
import '../controller/admindevice_controller.dart';

class AdminDeviceScreen extends StatefulWidget {
  const AdminDeviceScreen({Key? key}) : super(key: key);

  @override
  State<AdminDeviceScreen> createState() => _AdminDeviceScreenState();
}

class _AdminDeviceScreenState extends State<AdminDeviceScreen> {
  final AdminDeviceController adminDeviceController = Get.put(AdminDeviceController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      adminDeviceController.fnDeviceList();

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
   return Scaffold(

      resizeToAvoidBottomInset: false,

      body: Container(

        height: size.height,
        width: size.width,
          decoration: boxDecoration(Colors.white, 10),
          margin: const EdgeInsets.all(10),
          padding:const  EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.only(top: 17, right: 20, left: 20),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWithUnderLine(
                title: "Devices",
              ),
              TextField(
                controller: adminDeviceController.txtsearch,
                decoration: const InputDecoration(
                    label: Text('Search Device'),
                    prefixIcon: Icon(Icons.search)
                ),
                onChanged: (value){
                  adminDeviceController.fnDeviceList();
                },


                //  onTap: adminUserController.fnUserLookup
              ),
              gapHC(20),
              Expanded(
                child: ListView.builder(
                    itemCount: adminDeviceController.deviceList.length,
                    itemBuilder: (context,index){
                      var datas = adminDeviceController.deviceList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.lightfontcolor.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(5)),
                            // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.devices,size: 23),
                                        gapWC(15),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            tsw(datas["DEVICE_NAME"].toString().toUpperCase(), AppColors.fontcolor, 14,FontWeight.w600),
                                            tsw(datas["DEVICE_ID"].toString().toUpperCase(), AppColors.fontcolor, 12,FontWeight.w600),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Bounce(
                                    duration: const Duration(milliseconds: 110),
                                    onPressed: (){
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: tcnw("Are you sure?", AppColors.fontcolor, 18,TextAlign.start,FontWeight.w500),
                                              content: tcnw( "Do you want to ${datas["STATUS"].toString()=="A"?"Block":"Active"}",AppColors.fontcolor,12,TextAlign.start,FontWeight.w500),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: tc("No",AppColors.primarycolor,13),
                                                ),
                                                TextButton(
                                                  onPressed: (){
                                                    adminDeviceController.fnUpdatedev(datas["DEVICE_ID"].toString());
                                                    Get.back();
                                                  },
                                                  child: tc("Yes",AppColors.primarycolor,13),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: 110,
                                      decoration:  BoxDecoration(
                                          color:datas["STATUS"].toString()=="A"?AppColors.primarycolor: AppColors.subcolor,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: tcnw(datas["STATUS"].toString()=="A"?"Active":"Blocked", AppColors.white, 15,TextAlign.center,FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
              )



            ],
          ))
                          )),


    );
  }
}
