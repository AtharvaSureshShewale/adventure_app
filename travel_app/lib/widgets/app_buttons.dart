import 'package:flutter/material.dart';

import 'package:travel_app/widgets/app_text.dart';

// ignore: must_be_immutable
class AppButtons extends StatelessWidget {

  String? text;
  IconData? icon;
  final Color color;
  final Color bgColor;
  double size;
  final Color borderColor;
  bool? isIcon;

  AppButtons({super.key, 
  this.icon,
  this.text="Hi",
  this.isIcon=false,
  required this.size,
  required this.color, 
  required this.bgColor, 
  required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(    
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor,width: 1.0),
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      child: isIcon==false?Center(child: AppText(text: text!,color: color,)):Center(child: Icon(icon,color: color,)),
    );
  }
}