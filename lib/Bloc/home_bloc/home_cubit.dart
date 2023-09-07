import 'package:diverge_task/Bloc/home_bloc/home_state.dart';
import 'package:diverge_task/core/Repository/repository.dart';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  PlacesResponseModel? model;


  Future<dynamic> getPlaces() async{
    emit(HomeLoadingState());
    model = await Repository().getPlacesData();
    if(model!=null&&model!.popular!=null){
      emit(HomeSuccessState(model!));
    }else{
      emit(HomeErrorState());
    }
    return model;
  }
}
