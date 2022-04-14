// import 'package:app/main.dart';
// import 'package:flutter/material.dart';
//
// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);
//
//   @override
//   State<Splash> createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//     _navigatetohome();
//   }
//
//   _navigatetohome() async {
//     await Future.delayed(const Duration(milliseconds: 1200), () {});
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => const MyHomePage()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 250,
//           child: Image.asset('assets/images/logo.png'),
//         ),
//       ),
//     );
//   }
// }
