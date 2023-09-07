import 'package:diverge_task/Bloc/place_details_bloc/place_details_state.dart';
import 'package:diverge_task/core/Repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart' as dio;

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit() : super(PlaceDetailsInitial());

  static PlaceDetailsCubit get(context) => BlocProvider.of(context);

  dio.Response? model;


  Future<dynamic> getBookingAPi() async{
    emit(PlaceDetailsLoadingState());
    model = await Repository().getBookingApi();
    if(model!=null){
      emit(PlaceDetailsSuccessState(model!));
    }else{
      emit(PlaceDetailsErrorState());
    }
    return model;
  }

}
