import 'package:diverge_task/custom/d_text.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';


AppBar appBar({String? text,double? titleSpacing,bool isCenter = false,bool backBtn = true,required BuildContext context,List<Widget>? actions,
  refreshCheck=true,double? elevation,Widget? titleWidget}){
  return AppBar(surfaceTintColor: Colors.white,
      centerTitle: isCenter,titleSpacing: titleSpacing ?? 0,bottomOpacity: 0,
      elevation: elevation ?? 0.3,
      backgroundColor:Constants.white,title: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Row(mainAxisAlignment:isCenter? MainAxisAlignment.center:MainAxisAlignment.start,
    children: [
        if(text == null) Flexible(child: titleWidget??const SizedBox.shrink()),
        // if(text == null)const DImage("Logo (2)",width: 30,height: 30,fit: BoxFit.scaleDown),
        if(text != null) Flexible(child: titleWidget ?? DText(title: text, size: PSize.large,fontColor: Constants.black,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis)),
    ],
  ),
      ),
      leading: backBtn ? IconButton(onPressed: ()=> Navigator.pop(context,refreshCheck),
          icon: const Icon(Icons.arrow_back_ios,color: Constants.sky)) : null,
  actions: actions);


}

