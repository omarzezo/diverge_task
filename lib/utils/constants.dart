import 'package:flutter/material.dart';

class Constants {
  static const yellow =  Color(0xffFDE047);
  static const sky =  Color(0xff0EA5E9);
  static const red =  Color(0xffEF4444);
  static const grey =  Color(0xffE2E8F0);
  static const grey1 =  Color(0xffF1F5F9);
  static const grey2 =  Color(0xffF8FAFC);
  static const greyN3 =  Color(0xffCFC8D5);
  static const black =  Color(0xff1D093C);
  static const green =  Color(0xff00D847);
  static const white =  Color(0xffffffff);
  static const whiteBackground =  Color(0xfff5f5f5);

//network
  static const String baseurl = "https://api.themoviedb.org/3";
  static const String apiKey = "46e11de373f0f984146aef4aa74f327a";
  static const String topRatedMovies = "$baseurl/movie/top_rated?api_key=$apiKey";

  // https://api.themoviedb.org/3/movie/top_rated?api_key=46e11de373f0f984146aef4aa74f327a
}

enum PSize {
  doubleLarge,
  veryLarge,
  large,
  medium,
  small,
  caption
}

enum PStyle {
  primary,
  secondary,
  tertiary,
  link
}

