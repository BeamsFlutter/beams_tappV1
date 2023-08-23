

import 'dart:async';

import 'package:beams_tapp/constants/common_functn.dart';
import 'package:beams_tapp/view/commonController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

import '../../constants/color_code.dart';
import '../../constants/string_constant.dart';
import '../../constants/styles.dart';
import '../../storage/preference.dart';
import '../controller/rdrCounterPage_controller.dart';

class ReadrCounterScreen extends StatefulWidget {
  final dynamic pr_counterslIst;

  const ReadrCounterScreen({super.key, this.pr_counterslIst});

  @override
  State<ReadrCounterScreen> createState() => _ReadrCounterScreenState();
}

class _ReadrCounterScreenState extends State<ReadrCounterScreen>{
  final ReaderCounterController readerCounterController = Get.put(ReaderCounterController());
  final CommonController commonController = Get.put(CommonController());
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var datas;
  var selected_datas =false;

  Color changingColor = Colors.green;
  int start = 0;
  late Timer timer;

  // late AnimationController controller;
  //
  // Animatable<Color> background = TweenSequence<Color>([
  //   TweenSequenceItem(
  //     weight: 1.0,
  //     tween: Tween(
  //       begin: Colors.red,
  //       end: Colors.green,
  //     ),
  //   ),
  //   TweenSequenceItem(
  //     weight: 1.0,
  //     tween: Tween(
  //       begin: Colors.green,
  //       end: Colors.blue,
  //     ),
  //   ),
  //   TweenSequenceItem(
  //     weight: 1.0,
  //     tween: Tween(
  //       begin: Colors.blue,
  //       end: Colors.pink,
  //     ),
  //   ),
  // ]);
  @override
  void initState() {
    // TODO: implement initState
    readerCounterController.selectCounter=0;
    dprint("Parameter List.........................");
    dprint(widget.pr_counterslIst);
    datas = widget.pr_counterslIst;


    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      start++;
      _changeColor();
    });
    super.initState();
  }

  _changeColor() {
    setState(() {
      if (start % 8 == 0) {
        changingColor = AppColors.appReaderDarkBlck.withOpacity(0.3);
      } else if (start % 8 == 1) {
        changingColor = Colors.blue;
      } else if (start % 8 == 2) {
        changingColor = Colors.red;
      } else if (start % 8 == 3) {
        changingColor = Colors.yellow;
      } else if (start % 8 == 4) {
        changingColor = AppColors.appReaderBgRed;
      } else if (start % 8 == 5) {
        changingColor = Colors.purpleAccent;
      } else if (start % 8 == 6) {
        changingColor = Colors.pinkAccent;
      } else if (start % 8 == 7) {
        changingColor = Colors.cyanAccent;
      } else if (start % 8 == 8) {
        changingColor = AppColors.appReaderBgBlue;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(),
      drawer: switchDrawer(),
      body: Container(
        padding: MediaQuery.of(context).padding,
        height: size.height,
        width: size.width,
        decoration:  boxGradientTCBC(AppColors.appReaderBgRed,
            AppColors.appReaderBgBlue,0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Builder(builder: (context){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bounce(
                        duration: const Duration(milliseconds: 110),
                      onPressed: (){
                        _scaffoldKey.currentState!.openDrawer();
                      },

                        child: const Icon(Icons.swap_vert_circle_rounded,color: AppColors.white,size: 37,)),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      decoration: boxBaseDecoration(AppColors.appReaderDarkRED, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.home,color: AppColors.white,size: 20,),
                          gapWC(5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              tc((datas["siteName"]??"").toString(), AppColors.white, 8),
                              tcn((commonController.wstrSiteCode.value).toString(), AppColors.white, 8,TextAlign.center),
                            ],
                          )
                        ],
                      ),

                    ),
                    Bounce(
                        onPressed: (){
                          dprint("opendrawerrrr");
                          _scaffoldKey.currentState!.openEndDrawer();

                        //  Scaffold.of(context).openEndDrawer();
                        },
                        duration: const Duration(milliseconds: 110),
                        child: const Icon(Icons.menu,color: AppColors.white,size: 35,))
                  ],
                );
              }),

              gapHC(10),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),

                  width: double.infinity,
                  decoration: boxBaseDecoration(changingColor, 30),
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: boxBaseDecoration(datas["bgColor"], 30),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              gapHC(5),
                              // https://clipart-library.com/images/8ixK8bzBT.png
                              Image.network((datas["imageUrl"]??"").toString(),fit: BoxFit.fill,width: 150,height: 120,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: datas["bgColor"],
                                    alignment: Alignment.center,
                                    child:  Container(

                                    ),
                                  );
                                }, ),

                              tcTone((datas["counterName"]??"").toString()??"", Colors.red, 35),

                              Column(
                                children: [
                                  tcn("PRICE", Colors.black87, 35, TextAlign.center),
                                  tc(mfnDbl(datas["price"]??"").toString(), AppColors.appReaderDarkbGbLUE, 60),
                                ],
                              ),

                              Column(
                                children: [
                                  Image.asset("assets/gifs/removeBg/tap.gif",width: 70,height: 70,color:Colors.black38 ),
                                  tcn("Tap to Play", Colors.black38 , 20, TextAlign.center),
                                ],
                              ),




                            ],
                          ),
                        ),
                        Container(
                          decoration: boxBaseDecoration(Colors.grey.withOpacity(0.3), 20),
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                          margin: EdgeInsets.only(bottom: 40,right: 20,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              tc("ACTIVE GUEST", AppColors.appReaderDarkbGbLUE, 20),
                              tc(mfnInt(datas["activeGuestCount"]??"").toString(), AppColors.appReaderDarkbGbLUE, 28)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              gapHC(2),
              tc("Beams", AppColors.white, 20),
              tcS("Fungate", AppColors.white, 15),
            ],
          ),

        ),
      ),
    );
  }


  // switchDrawer(){
  //   return Drawer(
  //     child:    Container(
  //       padding: EdgeInsets.only(top: 10),
  //       child: ListView(
  //         children:  List.generate(readerCounterController.lstr_counterList.length, (index) {
  //           return Bounce(
  //             duration: const Duration(milliseconds: 110),
  //             onPressed: (){
  //               dprint(         readerCounterController.lstr_counterList[index]["counterName"]);
  //               setState(() {
  //                 datas=   readerCounterController.lstr_counterList[index];
  //               });
  //               Get.back();
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 5,left: 10,right: 10),
  //               child: ListTile(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                   side: BorderSide(color: Colors.black)
  //                 ),
  //                  tileColor: Colors.amber,
  //                  leading: Image.network((readerCounterController.lstr_counterList[index]["imageUrl"]??"").toString(),fit: BoxFit.cover,width: 30,height: 30,
  //                   errorBuilder: (context, error, stackTrace) {
  //                     return Container(
  //                       color: datas[index]["bgColor"],
  //                       alignment: Alignment.center,
  //                       child:  Container(
  //
  //                       ),
  //                     );
  //                   }, ),
  //                  title: Text((readerCounterController.lstr_counterList[index]["counterName"]??"").toString(),style:
  //                    TextStyle(color: Colors.black,fontSize: 15)),
  //                  contentPadding: EdgeInsets.only(left: 8),
  //                  //title: tc((readerCounterController.lstr_counterList[index]["counterName"]??"").toString(),Colors.black,15),
  //                  subtitle: Text( (readerCounterController.lstr_counterList[index]["counterCode"]??"").toString(),),
  //
  //                 // subtitle: tcn( (readerCounterController.lstr_counterList[index]["counterCode"]??"").toString(),Colors.black,12,TextAlign.center),
  //               ),
  //             ),
  //           );
  //         }),
  //       ),
  //     )
  //   );
  // }


  switchDrawer(){
    return Drawer(
        child:   Padding(
          padding: MediaQuery.of(context).padding,
          child: Column(
            children: [
              gapHC(3),
              tc("Select Counter", Colors.black, 23),
              Divider(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: List.generate(readerCounterController.lstr_counterList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5,),
                      child: ListTile(
                        selectedColor: Colors.black,
                        selectedTileColor: Colors.grey.withOpacity(0.4),
                        selected: readerCounterController.selectCounter==index,
                        leading: Image.network((readerCounterController.lstr_counterList[index]["imageUrl"]??"").toString(),fit: BoxFit.cover,width: 30,height: 30,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: datas[index]["bgColor"],
                              alignment: Alignment.center,
                              child:  Container(

                              ),
                            );
                          }, ),

                        onTap: (){
                          dprint( readerCounterController.lstr_counterList[index]["counterName"]);

                          setState(() {
                            datas=   readerCounterController.lstr_counterList[index];
                            readerCounterController.selectCounter=index;
                            dprint( readerCounterController.selectCounter);
                          });

                          Get.back();
                        },
                        title: Text((readerCounterController.lstr_counterList[index]["counterName"]??"").toString(),style: TextStyle(color: Colors.black,fontSize: 15)),
                        contentPadding: EdgeInsets.only(left: 18,right: 8),
                        //title: tc((readerCounterController.lstr_counterList[index]["counterName"]??"").toString(),Colors.black,15),
                        subtitle: Text( (readerCounterController.lstr_counterList[index]["counterCode"]??"").toString(),),

                        // subtitle: tcn( (readerCounterController.lstr_counterList[index]["counterCode"]??"").toString(),Colors.black,12,TextAlign.center),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        )
    );
  }

  // List<Widget> getCounterList() {
  //
  //   final List<Widget> counterList = <Widget>[];
  //   var srno=0;
  //   for(var e in readerCounterController.lstr_counterList){
  //     counterList.add(
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 5,),
  //           child: ListTile(
  //             leading: Image.network((e["imageUrl"]??"").toString(),fit: BoxFit.cover,width: 30,height: 30,
  //               errorBuilder: (context, error, stackTrace) {
  //                 return Container(
  //                   color: datas[srno]["bgColor"],
  //                   alignment: Alignment.center,
  //                   child:  Container(
  //
  //                   ),
  //                 );
  //               }, ),
  //
  //
  //             onTap: (){
  //               dprint( e["counterName"]);
  //
  //               setState(() {
  //                 datas= e;
  //               });
  //
  //               Get.back();
  //             },
  //             title: Text((e["counterName"]??"").toString(),style: TextStyle(color: Colors.black,fontSize: 15)),
  //             contentPadding: EdgeInsets.only(left: 18,right: 8),
  //             //title: tc((readerCounterController.lstr_counterList[index]["counterName"]??"").toString(),Colors.black,15),
  //             subtitle: Text( (e["counterCode"]??"").toString(),),
  //
  //             // subtitle: tcn( (readerCounterController.lstr_counterList[index]["counterCode"]??"").toString(),Colors.black,12,TextAlign.center),
  //           ),
  //         )
  //
  //
  //
  //     );
  //     srno=srno+1;
  //
  //   }
  //   return counterList;
  // }

}
