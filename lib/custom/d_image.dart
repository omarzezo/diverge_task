import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DImage extends StatelessWidget {
  final String imageName;
  final String? label;
  final Color? color;
  final double? height,width;
  final BoxFit fit;
  const DImage(this.imageName,{Key? key, this.color, this.height, this.width, this.fit = BoxFit.cover, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SvgPicture.asset(
        "assets/imgs/$imageName.svg",
        color: color,
        fit: fit,
        height: height,
        width: width,
        semanticsLabel: label
    );
  }

}