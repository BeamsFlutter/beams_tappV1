import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_code.dart';

class CommonTextStyle{

  static  TextStyle appBarheader =  const TextStyle(
      fontSize: discrFontSize,
      fontWeight: FontWeight.w700,
      // color: AppColors.appBgColor
  );
  static TextStyle appHeader(FontWeight fontWeight) =>   TextStyle(
      fontSize: titleFontSize,
      fontWeight: fontWeight,
      // color: AppColors.appBgColor
  );
  static  TextStyle appDescr =  const TextStyle(
      fontSize: discrFontSize,
      fontWeight: FontWeight.w500,

      // color: AppColors.appBgColor
  );


}


const double titleFontSize = 23;
const double discrFontSize = 16.0;
const double priceFontSize = 23;


SizedBox gapHC(double h) =>
    SizedBox(
      height: h,
    );

SizedBox gapW() =>
    const SizedBox(
      width: 20,
    );

SizedBox gapWC(double w) =>
    SizedBox(
      width: w,
    );

Image imageSet(image, size) =>
    Image.asset(
      image,
      width: size,

    );

Text th(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: size,color: color),);
Text ts(text,color,double size) => Text(text,style: TextStyle(fontSize: size,color: color),);
Text tsw(text,color,double size,FontWeight fontWight) => Text(text,style: TextStyle(fontSize: size,color: color,fontWeight: fontWight),);
Text tcs(text,color,double size,) => Text(text,style:TextStyle(fontSize: size,color: AppColors.white),);
Text tcn(text,color,double size,align) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color),textAlign: align,);
Text tcnw(text,color,double size,align,fontwight) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color,fontWeight: fontwight),textAlign: align,);
Text tcnL(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color),maxLines: 100,);
Text tc(text,color,double size) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: size,color: color,fontWeight: FontWeight.bold));
Text thL(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color,fontWeight: FontWeight.bold),maxLines: 100,);


BoxDecoration commonBoxDecoration(bgcolor) =>  BoxDecoration(
  color:bgcolor,
  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
);


//===========================================================Box Decorations

BoxDecoration boxDecoration(color,double radius) => BoxDecoration(
  color: color,
  boxShadow: [
    BoxShadow(
      color: Colors.blueAccent.withOpacity(0.2),
      blurRadius: 8,
      spreadRadius: 1,
      offset: Offset(4, 4),
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(radius)),
);
BoxDecoration boxDecorationC(color,double tr,double tl,double br,double bl) => BoxDecoration(
  color: color,
  boxShadow: [
    BoxShadow(
      color: Colors.blueAccent.withOpacity(0.2),
      blurRadius: 8,
      spreadRadius: 1,
      offset: Offset(4, 4),
    ),
  ],
  borderRadius: BorderRadius.only(topRight: Radius.circular(tr),topLeft: Radius.circular(tl),bottomLeft: Radius.circular(bl),bottomRight: Radius.circular(br)),
);
BoxDecoration boxBaseDecoration(color,double radius) => BoxDecoration(
  color: color,
  borderRadius: BorderRadius.all(Radius.circular(radius)),
);
BoxDecoration boxOutlineDecoration(color,double radius) => BoxDecoration(
  color: color,
  boxShadow: [

  ],
  border: Border.all(
    color: Colors.black87,width: 2.0,
  ),
  borderRadius: BorderRadius.all(Radius.circular(radius)),


);
BoxDecoration boxOutlineCustom(color,double radius,borderColor) => BoxDecoration(
  color: color,
  border: Border.all(
    color: borderColor,width: 1.0,
  ),
  borderRadius: BorderRadius.all(Radius.circular(radius)),


);
BoxDecoration boxOutlineCustom1(color,double radius,borderColor,width) => BoxDecoration(
  color: color,
  border: Border.all(
    color: borderColor,width: width,
  ),
  borderRadius: BorderRadius.all(Radius.circular(radius)),


);
BoxDecoration boxOutlineCustom2(color,double radius,borderColor,width) => BoxDecoration(
  color: color,
  border: Border.all(
    color: borderColor,width: width,
  ),
  borderRadius: BorderRadius.all(Radius.circular(radius)),


);
BoxDecoration boxImageDecoration(img,double radius) => BoxDecoration(
    image: DecorationImage(
        image: AssetImage(img),
        fit: BoxFit.cover
    ),
    borderRadius: BorderRadius.all(Radius.circular(radius))
);


// dprint(val){
//   if(kDebugMode){
//     print(val);
//   }
// }



