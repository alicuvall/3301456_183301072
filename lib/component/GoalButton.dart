import 'package:flutter/material.dart';
import 'package:travel_app/component/NavigatorListTile.dart';

class GoalButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Function() onTap;

  GoalButton({required this.backgroundColor, required this.textColor, required this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigatorListTile(
      title: 'Amaçlarım',
      icon: Icon(Icons.assignment_rounded, color: iconColor == null ? Colors.white : iconColor,),
      backgroundColor: backgroundColor,
      textColor: textColor,
      onTap: onTap,
    );
  }
}
