


import 'package:beams_tapp/constants/color_code.dart';
  
import 'package:flutter/material.dart';

import '../../../constants/common_functn.dart';

class BottomNavigationItem extends StatefulWidget {
  final String  mode;
  final Function  fnPage;
  final Function  fnSave;
  final Function  fnEdit;
  final Function  fnAdd;
  final Function  fnCancel;
  final Function  fnDelete;
  const BottomNavigationItem({Key? key, required this.mode,  required this.fnPage, required this.fnSave, required this.fnEdit, required this.fnAdd, required this.fnCancel, required this.fnDelete}) : super(key: key);

  @override
  _BottomNavigationItemState createState() => _BottomNavigationItemState();
}

class _BottomNavigationItemState extends State<BottomNavigationItem> {

  var mode = '';
  var selectedItemV = 0;
  var selectedItemA = 0;
  var selectedItemE = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dprint("fnmoode ${fnMode()}");
    return fnMode() == 'VIEW'  ?
    BottomNavigationBar(
      items:   const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
            icon: Icon(
              Icons.first_page_rounded,
              color:AppColors.primarycolor,),
            label:'First',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.skip_previous,
              color: AppColors.primarycolor,),
            label:'Previous',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.skip_next,
              color: AppColors.primarycolor,),
            label:'Next',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.last_page,
              color: AppColors.primarycolor,),
            label:'Last',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_box,
              color: AppColors.primarycolor,),
            label:'Add',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.edit,
              color: AppColors.primarycolor,),
            label:'Edit',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever,
              color: AppColors.primarycolor,),
            label:'Delete',
            backgroundColor: Colors.white)

      ],

      type: BottomNavigationBarType.shifting,
      currentIndex: selectedItemV,
      selectedItemColor: AppColors.primarycolor,
      iconSize: 20,
      onTap: (index){
        setState(() {
          selectedItemV = index;
          fnButtonClick(index);
        });
      },
      elevation: 3,
    ) :
    BottomNavigationBar(
      items:  const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
            icon: Icon(Icons.save_sharp,
              color: AppColors.primarycolor,),
            label:'Save',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.cancel,
              color: AppColors.primarycolor,),
            label:'Cancel',
            backgroundColor: Colors.white),

      ],

      type: BottomNavigationBarType.shifting,
      currentIndex: selectedItemA,
      selectedItemColor: AppColors.primarycolor,
      iconSize: 25,
      onTap: (index){
        setState(() {
          selectedItemA = index;
          fnButtonClick(index);
        });
      },
      elevation: 3,
    );


  }

  fnMode(){
    var m = '';
    m = widget.mode;
    return m;
  }

  fnButtonClick(index){
    if(widget.mode == 'VIEW'){
      switch (index) {
        case 0:
          widget.fnPage('FIRST');
          break;
        case 1:
          widget.fnPage('PREVIOUS');
          break;
        case 2:
          widget.fnPage('NEXT');
          break;
        case 3:
          widget.fnPage('LAST');
          break;
        case 4:
          widget.fnAdd();
          break;
        case 5:
          widget.fnEdit();
          break;
        case 6:
          widget.fnDelete(context);
          break;
        default:
          break;
      }
    }else{
      switch (index) {
        case 0:
          widget.fnSave();
          break;
        case 1:
          widget.fnCancel();
          break;
      }
    }
  }


}

