import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:diverge_task/utils/place_data.dart';


abstract class RemoteDataSourceBase {
  Future<dynamic> getVacation();
  Future<dynamic> getBookingApi();
}

class RemoteDataSource implements RemoteDataSourceBase {
  static Dio dio = Dio();

  static initialDio() {
    dio = Dio(
      BaseOptions(
        baseUrl:'',
        receiveDataWhenStatusError: true,
      ),
    );
    dio..options.connectTimeout = 1 * 1000
      ..options.receiveTimeout = 10 * 1000;
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      request: true,
      responseBody: true,
    ));
    return dio;
  }

  @override
  Future<PlacesResponseModel> getVacation() async {
    PlacesResponseModel model = PlacesResponseModel.fromJson(jsonDecode(PlacesData().data));
    return model;
  }

  @override
  Future<Response> getBookingApi() async {
    var response = await dio.get(Constants.topRatedMovies);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('${response.statusMessage}');
    }
  }
}

