import 'package:diverge_task/custom/d_image.dart';
import 'package:diverge_task/custom/tab_bar/fab_bottom_item.dart';
import 'package:diverge_task/ui/home_screen.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';

class TabViewScreen extends StatefulWidget {
  const TabViewScreen({Key? key}) : super(key: key);
  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> with TickerProviderStateMixin{
  late final TabController _tabController = TabController(length:4, vsync: this);
  int? index;
  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Scaffold(
          bottomNavigationBar:FABBottomAppBar(
            color: Constants.black.withOpacity(0.3),
            backgroundColor: Constants.grey2.withOpacity(0.4),
            selectedColor: Constants.sky,
            onTabSelected:(value) {
              setState(() {index=value;});
            },
            items: [
              FABBottomAppBarItem(iconData:'trip', text: 'My trip'),
              FABBottomAppBarItem(iconData:'save', text: 'Saved'),
              FABBottomAppBarItem(iconData:'profile_tab', text: 'Profile'),
              FABBottomAppBarItem(iconData:'setting', text: 'Settings'),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom:24),
            child: SizedBox(width:65,height:65,
              child: FloatingActionButton(elevation:2,backgroundColor:Constants.sky,shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
                tooltip: 'Increment',
                onPressed: () {  },
                child: const DImage('home',width:35,height:35,),
              ),
            ),
          ),
          body:TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children:  const [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
            ],
          ),
        ),
      ],
    );
  }

}




