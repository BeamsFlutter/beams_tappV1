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
Text tcS(text,color,double size) => Text(text,style: GoogleFonts.alexBrush(fontSize: size,color: color,fontWeight: FontWeight.bold));
Text tcK(text,color,double size) => Text(text,style: GoogleFonts.knewave(fontSize: size,color: color,fontWeight: FontWeight.bold));
Text tcPM(text,color,double size) => Text(text,style: GoogleFonts.permanentMarker(fontSize: size,color: color,fontWeight: FontWeight.bold));
Text tcTone(text,color,double size) => Text(text,style: GoogleFonts.titanOne(fontSize: size,color: color,fontWeight: FontWeight.bold));
Text tcH(text,color,double size,height) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: size,color: color,height: height,fontWeight: FontWeight.bold));
Text tcSH(text,color,double size,height) => Text(text,style: GoogleFonts.alexBrush(fontSize: size,height: height,color: color,fontWeight: FontWeight.bold));
Text tcnH(text,color,double size,align,height) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color,height: height),textAlign: align,);

Text tHead(text,color) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 45,color: color,fontWeight: FontWeight.bold));
Text tHead1(text,color,) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 30,color: color,fontWeight: FontWeight.bold));
Text tHead4(text,color,) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 30,color: color));
Text tHead3(text,color,) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 25,color: color,fontWeight: FontWeight.bold));
Text tHead2(text,color,) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 16,color: color,fontWeight: FontWeight.bold));
Text tSubHead(text,color, align) => Text(text,style: GoogleFonts.poppins(fontSize: 16,color: color),textAlign: align,);
Text tBody(text,color,align,{height1}) => Text(text,style: GoogleFonts.poppins(fontSize: 12,color: color,height: height1),textAlign: align,);
Text tBodyBold(text,color, {height1}) => Text(text,style: GoogleFonts.poppins(fontSize: 12,color: color,fontWeight: FontWeight.bold,height: height1),);
Text tSub(text,color,double size,align) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color),textAlign: align,);

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
BoxDecoration boxDecoration1(color,double radius) =>  BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: color,
      blurRadius: 8,
      spreadRadius: 1,
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
    color: Colors.white,width: 2.0,
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

BoxDecoration boxGradientTCBC(color1,color2,radius)=>BoxDecoration(
  gradient: LinearGradient(
    colors: [
      color1,
      color2
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
    borderRadius: BorderRadius.all(Radius.circular(radius))
);
BoxDecoration boxGradientCLBR(color1,color2,radius)=>BoxDecoration(
  gradient: LinearGradient(
    colors: [
      color1,
      color2,

    ],
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
  ),
    borderRadius: BorderRadius.all(Radius.circular(radius))
);
BoxDecoration boxGradientCLCR(color1,color2,radius)=>BoxDecoration(
    gradient: LinearGradient(
      colors: [
        color1,
        color2,

      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(radius))
);

// dprint(val){
//   if(kDebugMode){
//     print(val);
//   }
// }



