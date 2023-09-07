import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
@immutable
abstract class PlaceDetailsState {}

class PlaceDetailsInitial extends PlaceDetailsState {}
class PlaceDetailsLoadingState extends PlaceDetailsState {}
class PlaceDetailsSuccessState extends PlaceDetailsState {
  final dio.Response  model;
  PlaceDetailsSuccessState(this.model);
}
class PlaceDetailsErrorState extends PlaceDetailsState {}
