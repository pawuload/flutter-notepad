import 'package:app/screens/login_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'common/constans/theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'notepad',
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),
        nextScreen: const MyHomePage(),
        backgroundColor: AppTheme.colors.lightestBrown,
        duration: 1000,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'notepad',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const AuthScreen(),
    );
  }
}

// StreamBuilder<dynamic>(
// stream: FirebaseFirestore.instance
//     .collection('chats/8G7xuGsWARWwcj3QaUBN/msg')
// .snapshots(),
// builder: (ctx, streamSnapshot) {
// if (streamSnapshot.connectionState == ConnectionState.waiting) {
// return const Center(
// child: CircularProgressIndicator(),
// );
// }
// final documents = streamSnapshot.data.docs;
// return ListView.builder(
// itemCount: documents.length,
// itemBuilder: (ctx, index) => Container(
// padding: const EdgeInsets.all(8),
// child: Text(documents[index]['text']),
// ),
// );
// },
// ),
// floatingActionButton: FloatingActionButton(
// child: const Icon(Icons.add),
// onPressed: () {
// FirebaseFirestore.instance.collection('chats/8G7xuGsWARWwcj3QaUBN/msg').add({
// 'text' : 'Button has been clicked'
// });
// },
// ),
