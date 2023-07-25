import 'package:beams_tapp/common_widgets/common_textfield.dart';
import 'package:beams_tapp/constants/color_code.dart';
import 'package:beams_tapp/constants/enums/txt_field_type.dart';
import 'package:beams_tapp/constants/styles.dart';
import 'package:beams_tapp/view/lookup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class LookupSearch extends StatefulWidget {
  final Function callbackfn;
  final String table_name;
  final List column_names;
  final List filter;
  final String key_column;

  const LookupSearch(
      {Key? key,
        required this.callbackfn,
        required this.table_name,
        required this.column_names,
        required this.filter,
        this.key_column = ''})
      : super(key: key);

  @override
  State<LookupSearch> createState() => _LookupSearchState();
}

class _LookupSearchState extends State<LookupSearch> {
  final LookupController lookupController = Get.put(LookupController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      lookupController.fnLookupSearch(
          widget.table_name, widget.column_names, widget.filter,"");
    });

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
        title: tsw("Search", AppColors.white, 20, FontWeight.w500),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: CommonTextfield(
                controller: lookupController.search_controller,
                textFormFieldType: TextFormFieldType.search,
                shadow: 30.0,
                opacityamount: 0.4,
                hintText: 'Search',
                onChangeCallback: (content) {
                  lookupController.fnLookupSearch(widget.table_name,
                      widget.column_names, widget.filter,content);
                }),
          ),
          Expanded(
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.only(top: 10),
              decoration: commonBoxDecoration(AppColors.white),
              child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 3),
                  child: Obx(() => lookupController.search_result.value.isNotEmpty ?ListView.builder(
                      itemCount: lookupController.search_result.value.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = lookupController.search_result.value[index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                              onTap: () {
                                widget.callbackfn;
                              },
                              child: wColumcard(data)),
                        );
                      }):

                  Center(
                    child: tc("No Data Found", AppColors.lightfontcolor, 14),
                  )
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget wColumcard(data) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: () {
        widget.callbackfn(data);
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.lightfontcolor.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: wDataRow(data)),
        ),
      ),
    );
  }

  List<Widget> wDataRow(data) {
    List<Widget> rtnList = [];
    for (var e in widget.column_names) {
      rtnList.add( e["DISPLAY"] != "N" ?Row(
        children: [
          
          tcnw(e["DISPLAY"], AppColors.fontcolor, 11,TextAlign.center,FontWeight.w500),
          gapWC(5),
          tcn( data[e["COLUMN"]].toString().toUpperCase(), AppColors.fontcolor, 11,
              TextAlign.center)
        ],
      ):gapHC(0));
    }

    return rtnList;
  }
}
