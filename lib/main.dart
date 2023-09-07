import 'package:diverge_task/Bloc/home_bloc/home_cubit.dart';
import 'package:diverge_task/Bloc/place_details_bloc/place_details_cubit.dart';
import 'package:diverge_task/core/DataSource/localData/cache_helper.dart';
import 'package:diverge_task/core/DataSource/remoteData/remote_data_source.dart';
import 'package:diverge_task/routes/routes_manager.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await RemoteDataSource.initialDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getPlaces()),
        BlocProvider(create: (context) => PlaceDetailsCubit()..getBookingAPi()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Constants.white,
          colorScheme: ColorScheme.fromSeed(seedColor:Constants.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.tabView,
        // home: const LanguageScreen(),
      ),
    );
    //
    //
    //   MaterialApp(
    //   title: 'Diverge Test',debugShowCheckedModeBanner:false,
    //   theme: ThemeData(
    //     primaryColor: Constants.white,
    //     colorScheme: ColorScheme.fromSeed(seedColor:Constants.white),
    //     useMaterial3: true,
    //   ),
    //   home:const TabViewScreen(),
    // );
  }
}

