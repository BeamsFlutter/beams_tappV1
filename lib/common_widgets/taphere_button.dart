// import 'package:flutter/material.dart';
//
//
// class TapHereButton extends StatefulWidget {
//   final String txt;
//   TapHereButton({Key? key,required this.txt}) : super(key: key);
//
//   @override
//   State<TapHereButton> createState() => _TapHereButtonState();
// }
//
// class _TapHereButtonState extends State<TapHereButton>with TickerProviderStateMixin  {
//   late AnimationController _opacityController;
//   late Animation<double> _opacity;
//   bool _showHint = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _opacityController = AnimationController(vsync: this,duration: const Duration(milliseconds: 800));
//     _opacity = CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut)..addStatusListener((status) {
//     if (status == AnimationStatus.completed) {
//     _opacityController.reverse();
//     } else if (status == AnimationStatus.dismissed) {
//     _opacityController.forward();
//     }
//     });
//     _opacityController.forward();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _opacityController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return !_showHint?FadeTransition(
//       opacity: _opacity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(Icons.arrow_back),
//           Padding(padding: const EdgeInsets.only(left: 8.0)),
//           Text(txt,
//             style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.blueGrey
//             ),
//           )
//         ],
//       ),
//     ):Container();
//   }
// }
//
