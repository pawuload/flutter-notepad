import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/widget/home_screen_button.dart';
import '../../common/constans/app_images.dart';
import './widget/home_screen_list_title.dart';
import './widget/home_screen_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeScreenButton(),
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
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: const <Widget>[
                    // To tylko tak na chwilę, poglądowo
                    HomeScreenListTitle(text: 'Suspendisse potenti.'),
                    HomeScreenListTitle(text: 'Fusce et ligula ornare, vestibulum.'),
                    HomeScreenListTitle(text: 'Nullam suscipit pulvinar.'),
                    HomeScreenListTitle(text: 'Lorem'),
                    HomeScreenListTitle(text: 'Lorem Ipsum'),
                    HomeScreenListTitle(text: 'Neque porro quisquam'),
                    HomeScreenListTitle(text: 'Ut auctor sapien in est.'),
                    HomeScreenListTitle(text: 'Proin porttitor'),
                    HomeScreenListTitle(text: 'Lorem'),
                    HomeScreenListTitle(text: 'Proin porttitor'),
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
