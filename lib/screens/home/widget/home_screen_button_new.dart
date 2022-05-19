import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:flutter/material.dart';

class HomeScreenButtonNew extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenButtonNew({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _animationTranslate = Tween<Offset>(
      begin: const Offset(0, 65),
      end: const Offset(0, 0),
    ).animate(state.buttonAnimationController);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedBuilder(
          animation: _animationTranslate,
          builder: (BuildContext context, Widget? child) {
            return Transform.translate(
              offset: _animationTranslate.value,
              child: child,
            );
          },
          child: _buildAllButtons(),
        ),
        GestureDetector(
          onTap: state.onHomePressed,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.brown,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 8,
                ),
              ],
            ),
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: state.buttonAnimationController,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({required Color? color, required IconData buttonIcon, required Function() onTap, required int num}) {
    final _animationScale = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(state.buttonAnimationController);
    return AnimatedBuilder(
      animation: _animationScale,
      builder: (BuildContext context, Widget? child) {
        return AnimatedScale(
          curve: Curves.easeInOutBack,
          scale: _animationScale.value,
          duration: Duration(milliseconds: num),
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(
              buttonIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllButtons() {
    return Column(
      children: [
        _buildButton(
          onTap: state.onButtonPressed,
          color: state.userState.user!.details.isPremium ? Colors.brown[300] : AppColors.premium,
          buttonIcon: AppIcons.premium,
          num: state.isButtonOpen ? 200 : 0,
        ),
        _buildButton(
          onTap: state.onSignOutPressed,
          color: Colors.brown[300],
          buttonIcon: AppIcons.logout,
          num: 100,
        ),
        _buildButton(
          onTap: state.onAddButtonPressed,
          color: Colors.brown[300],
          buttonIcon: AppIcons.add,
          num: state.isButtonOpen ? 0 : 170,
        ),
      ],
    );
  }
}
