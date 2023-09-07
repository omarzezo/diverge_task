import 'package:diverge_task/core/DataSource/remoteData/remote_data_source.dart';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'base_repository.dart';
import 'package:dio/dio.dart' as dio;

class Repository implements BaseRepository {
  @override
  Future getPlacesData() async {
    PlacesResponseModel model=await RemoteDataSource().getVacation();
    return model;
  }

  @override
  Future getBookingApi() async {
    dio.Response model=await RemoteDataSource().getBookingApi();
    return model;
  }
}
