// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
//
// class PrintScreen extends StatefulWidget {
//   const PrintScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PrintScreen> createState() => _PrintScreenState();
// }
//
// class _PrintScreenState extends State<PrintScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("title")),
//       body: PdfPreview(
//         build: (format) => _generatePdf(format, "title"),
//       ),
//     );
//   }
//
//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: format,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.SizedBox(
//                 width: double.infinity,
//                 child: pw.FittedBox(
//                   child: pw.Text(title, style: pw.TextStyle(font: font)),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Flexible(child: pw.FlutterLogo())
//             ],
//           );
//         },
//       ),
//     );
//
//     return pdf.save();
//   }
// }
