import 'package:app/common/constans/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/constans/app_images.dart';
import '../../common/widgets/app_button.dart';
import './widgets/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Spacer(flex: 6),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                  height: 100,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(AppImages.logo),
                  ),
                ),
                const Spacer(flex: 3),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: FloatingActionButton(
                    child: const Icon(AppIcons.logout),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: const <Widget>[
                    HomeCard(text: 'Suspendisse potenti.'),
                    HomeCard(text: 'Fusce et ligula ornare, vestibulum.'),
                    HomeCard(text: 'Nullam suscipit pulvinar.'),
                    HomeCard(text: 'Lorem'),
                    HomeCard(text: 'Lorem Ipsum'),
                    HomeCard(text: 'Neque porro quisquam'),
                    HomeCard(text: 'Ut auctor sapien in est.'),
                    HomeCard(text: 'Proin porttitor'),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AppButton(
                title: 'ADD',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
