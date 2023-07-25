import 'package:beams_tapp/common_widgets/lookup_search.dart';
import 'package:beams_tapp/common_widgets/title_withUnderline.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/settings/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  void initState() {
    settingsController.fngetpagedata();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("build Running");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primarycolor,
      appBar: AppBar(
        elevation: 0,
        title: tsw("Settings",AppColors.white,20,FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: size.height,
          width: size.width,
          decoration:  commonBoxDecoration(AppColors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 12,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const TitleWithUnderLine(title: "Settings",),
                gapHC(20),
                tsw("Printer",AppColors.fontcolor,14,FontWeight.w500),
                gapHC(10),
                Material(
                  elevation: 30,
                  borderRadius: BorderRadius.circular(8) ,
                  shadowColor: AppColors.lightfontcolor.withOpacity(0.4),
                  child: TextFormField(
                    showCursor:false,
                    keyboardType: TextInputType.none,
                    controller: settingsController.txtPrinter,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: "Printer",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color:  AppColors.lightfontcolor, fontSize: 13),
                        filled: true,

                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        suffixIcon: Icon(Icons.search,color: AppColors.fontcolor,)
                    ),
                    onTap: (){
                      print("object");
                      settingsController.fnGetPrinters();
                      wShowDialog(context);

                    },

                  ),
                )




              ],
            ),
          ),
        ),
      ),
    );
  }

  wShowDialog(context){
    Size size = MediaQuery.of(context).size;

    showDialog(context: context, builder: (_) {
      return Obx(() => AlertDialog(
        title: Text("Choose a printer"),
        content: SizedBox(
          width: double.maxFinite,
          height: size.height/2,
          child: ListView.builder(
            itemCount: settingsController.printerList.length,
            itemBuilder: (_, i) {
              return  RadioListTile(
                activeColor: AppColors.primarycolor,
                contentPadding: EdgeInsets.zero,
                value:settingsController.printerList[i],
                groupValue: settingsController.txtPrinter.text,
                dense: true,
                onChanged: (value){
                  settingsController.txtPrinter.text = value["NAME"];
                  settingsController.fnSavePrinterdatas(value["PATH"],value["NAME"],value["CODE"]);
                  print("Printerrrr value>>>> ${settingsController.txtPrinter.text}");
                  Get.back();
                },

                title: Text(settingsController.printerList[i]["NAME"].toString()),
              );
            },
          ),
        ),
      ));
    });

  }

}
