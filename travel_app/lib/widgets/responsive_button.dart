import 'package:flutter/material.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/app_text.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  
  bool? isResponsive;
  double? width;

  ResponsiveButton({super.key,
  this.width=120,
  this.isResponsive=false
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(

      child: Container(
        width: isResponsive==true?double.maxFinite:width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment: isResponsive==true?MainAxisAlignment.spaceEvenly:MainAxisAlignment.center,
          children: [
            isResponsive==true?AppText(text: "Book Trip Now",color: Colors.white,):Container(),
            Image.asset("assets/image/button_one.png"),
          ],
        ),
      ),
    );
  }
}