import 'package:app/common/constans/app_icons.dart';
import 'package:app/screens/add_screen/widget/add_screen_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddScreen extends HookWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 65),
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.4,
                    color: Colors.brown,
                  ),
                ),
              ),
              child: SizedBox(
                height: 60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    child: TextFormField(
                      maxLines: 100,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: 0.4,
                  color: Colors.brown,
                ),
              )),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                width: double.infinity,
                height: 85,
                child: const SingleChildScrollView(
                  child: Text('www.goggle.pl', style: TextStyle(fontSize: 15),),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddScreenButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () => Navigator.pop(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          AppIcons.exit,
                          color: Colors.brown,
                        ),
                        Text(
                          ' exit ',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          AppIcons.addImage,
                          color: Colors.brown,
                        ),
                        Text(
                          ' image ',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //--------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          AppIcons.addLink,
                          color: Colors.brown,
                        ),
                        Text(
                          ' link ',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          AppIcons.save,
                          color: Colors.brown,
                        ),
                        Text(
                          ' save ',
                          style: TextStyle(color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
