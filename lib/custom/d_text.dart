import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';


class DText extends StatelessWidget {
  final String title;
  final PSize size;
  final TextDecoration? decoration;
  final FontWeight fontWeight;
  final Color fontColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignText;
  const DText({Key? key, required this.title, required this.size,this.fontColor = Constants.black,
    this.fontWeight = FontWeight.w600, this.overflow,this.maxLines,this.decoration=TextDecoration.none, this.alignText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double fontSize = size == PSize.large ? 18.0 : size == PSize.medium ? 14.0 : size == PSize.small ? 12.0 : size==PSize.veryLarge ?20:
   size==PSize.doubleLarge ?30:10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title,textAlign: alignText ?? TextAlign.start,style: TextStyle(fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
            height: 1.2,
            letterSpacing: -0.02,
            decoration: decoration,
            overflow: overflow),maxLines:maxLines,)),
      ],
    );
  }

}

