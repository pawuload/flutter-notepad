import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/widget/details_screen_button.dart';
import 'package:app/screens/details_screen/widget/detiles_screen_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailsScreen extends HookWidget {
  final String title;
  final String description;

  const DetailsScreen({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useDetailsScreenState();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 80,
              child: DetailsScreenText(
                state: state.titleState,
                fontSize: 20,
                text: title,
                showBorder: true,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: DetailsScreenText(
                    state: state.descriptionState,
                    fontSize: 16,
                    text: description,
                  ),
                ),
              ),
            ),
            // const AddScreenUrl(),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child:  DetailsScreenButton(state: state,),
      ),
    );
  }
}
