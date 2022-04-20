import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/widgets/home_menu.dart';
import '../../common/constants/app_images.dart';
import './widgets/home_card.dart';
import './widgets/home_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeMenu(),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              height: 100,
              child: Hero(
                tag: 'logo',
                child: Image.asset(AppImages.logo),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.only(bottom: 0),
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(12),
                      children: const <Widget>[
                        // To tylko tak na chwilę, poglądowo
                        HomeCard(text: 'Suspendisse potenti.'),
                        HomeCard(text: 'Fusce et ligula ornare, vestibulum.'),
                        HomeCard(text: 'Nullam suscipit pulvinar.'),
                        HomeCard(text: 'Lorem'),
                        HomeCard(text: 'Lorem Ipsum'),
                        HomeCard(text: 'Neque porro quisquam'),
                        HomeCard(text: 'Ut auctor sapien in est.'),
                        HomeCard(text: 'Proin porttitor'),
                        HomeCard(text: 'Lorem'),
                        HomeCard(text: 'Proin porttitor'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
