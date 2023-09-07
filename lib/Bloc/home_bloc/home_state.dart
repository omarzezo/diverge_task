import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeSuccessState extends HomeState {
  final PlacesResponseModel  model;
  HomeSuccessState(this.model);
}
class HomeErrorState extends HomeState {}
