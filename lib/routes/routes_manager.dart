import 'package:diverge_task/ui/home_screen.dart';
import 'package:diverge_task/ui/tab_bar_screen.dart';
import 'package:flutter/material.dart';



class Routes{
  static const String splashRoute = "/";
  static const String home = "home";
  static const String tabView = "tab";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.home :
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.tabView :
        return MaterialPageRoute(builder: (_) => const TabViewScreen());
      default :
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title:  const Text('No Route Found'),
      ),
      body: const Center(child: Text('No Page Found'),),
    ));
  }
}