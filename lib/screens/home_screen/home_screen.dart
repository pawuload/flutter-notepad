import 'package:app/screens/home_screen/widget/home_screen_list_title.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/widget/home_screen_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app/common/constans/app_images.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeScreenButton(),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  HomeScreenListTitle(
                      text: 'adsdasdasd asdsa d sad fsd fsdf dsf sdf sdf sdf we fs dfdssfsfd sdfsdf dsfdsfsf sf fdg df fdgfd gdf '),
                  HomeScreenListTitle(text: 'asjd hasjkd haskdjasjd slkdhjk'),
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
    );
  }
}
