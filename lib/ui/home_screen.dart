import 'dart:io';
import 'package:diverge_task/Bloc/home_bloc/home_cubit.dart';
import 'package:diverge_task/Bloc/home_bloc/home_state.dart';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:diverge_task/custom/d_appbar.dart';
import 'package:diverge_task/custom/d_image.dart';
import 'package:diverge_task/custom/d_text.dart';
import 'package:diverge_task/ui/place_details_screen.dart';
import 'package:diverge_task/utils/common_functions.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  PlacesResponseModel model = PlacesResponseModel();
  late final TextEditingController controller = TextEditingController();
  XFile? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Constants.white,
      appBar:appBar(titleSpacing:24,backBtn:false,context:context,actions:[const Padding(
        padding: EdgeInsets.symmetric(horizontal:24), child: DImage('notification',width:30,height:30),)],
          titleWidget:Row(children: [
            imgFile!=null?InkWell(onTap:() async {
              imgFile=await getImage();
              setState(() {});
            }, child:CircleAvatar(backgroundImage:FileImage(File(imgFile!.path)),radius:20,backgroundColor:Colors.transparent),
            ):
            InkWell(onTap:() async {
              imgFile=await getImage();
              setState(() {});
            },child: Image.asset('assets/imgs/profile.jpg',width:40,height:40,)),
            const Padding(padding: EdgeInsets.only(left:10),
              child: DText(title:'Hello, Orlando!',size:PSize.veryLarge,fontColor:Constants.black,),
            )
          ])),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccessState) {
            model=state.model;
          }
        },
        builder: (context, state) {
          return ((state is HomeSuccessState)&&model.popular!=null&&model.popular!.isNotEmpty)?
              buildScreenData(model: state.model):const SizedBox.shrink();
        },
      )
    );
  }

  Widget buildScreenData({required PlacesResponseModel model}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24,vertical:10),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
          const DText(title:'Where do you want to explore today?', size:PSize.doubleLarge,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:20),
            child: CupertinoTextField(padding:const EdgeInsets.only(top:14,bottom:10,left:10),suffix:
            const Padding(padding: EdgeInsets.symmetric(horizontal:14),child: DImage('search')),controller:controller,placeholder:'Search destination...',
              placeholderStyle:const TextStyle(color:Constants.black,fontWeight:FontWeight.w100,fontSize:12),decoration:const BoxDecoration(
                color: Constants.grey1,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),),
          ),
          const Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,crossAxisAlignment:CrossAxisAlignment.center,children: [
            DText(title:'Choose Category',size:PSize.veryLarge,fontColor:Constants.black,),
            Padding(padding: EdgeInsets.only(top:8),
              child: DText(title:'See All',size:PSize.large,fontColor:Constants.black,fontWeight:FontWeight.w200,),
            ),
          ],
          ),

          //Horizontal list view
          Container(height:45,margin:const EdgeInsets.only(top:14,bottom:34),
            child: ListView.builder(itemBuilder:(context, index) {
              Categories item=model.categories?[index]??Categories();
              return categoryChild(item: item);
            },itemCount:model.categories!.length,scrollDirection:Axis.horizontal,
              shrinkWrap:true,),
          ),


          const Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,crossAxisAlignment:CrossAxisAlignment.center,children: [
            DText(title:'Favorite Place',size:PSize.veryLarge,fontColor:Constants.black,),
            Padding(padding: EdgeInsets.only(top:8),
              child: DText(title:'Explore',size:PSize.large,fontColor:Constants.black,fontWeight:FontWeight.w200,),
            ),
          ],
          ),

          // Horizontal List View
          Container(height:260,margin:const EdgeInsets.only(top:14,bottom:34),
              child: ListView.builder(itemBuilder:(context, index) {
                Places item=model.places?[index]??Places();
                return favoriteChild(index:index,item: item);
              },itemCount:model.places!.toList().length,scrollDirection:Axis.horizontal,
                shrinkWrap:true,)),


          const Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,crossAxisAlignment:CrossAxisAlignment.center,children: [
            DText(title:'Popular Package',size:PSize.veryLarge,fontColor:Constants.black,),
            Padding(padding: EdgeInsets.only(top:8),
              child: DText(title:'See All',size:PSize.large,fontColor:Constants.black,fontWeight:FontWeight.w200,),
            )]),

          // Vertical List View
          Container(margin:const EdgeInsets.only(top:14,bottom:34),
            child: ListView.builder(physics:const NeverScrollableScrollPhysics(),itemBuilder:(context, index) {
              Places item=model.popular?[index]??Places();
              return popularChild(item:item);
            },itemCount:model.popular!.toList().length,
              shrinkWrap:true,),
          ),

        ]),
      ),
    );
  }
  Widget categoryChild({required Categories item}){
    return Container(margin:const EdgeInsets.symmetric(horizontal:4),padding:const EdgeInsets.symmetric(horizontal:14,vertical:4),decoration:BoxDecoration(border: Border.all(color: Constants.grey2,),color:Constants.grey1,
        borderRadius: const BorderRadius.all(Radius.circular(20))),child:Row(mainAxisSize: MainAxisSize.min,children: [
      Image.asset('assets/imgs/${item.image??''}.png'),const Padding(padding:EdgeInsets.symmetric(horizontal:4)),
      DText(title:item.name??'',size:PSize.large,fontWeight: FontWeight.w600,)
    ]),);
  }

  Widget favoriteChild({required int index,required Places item}){
    return  Stack(children: <Widget>[
        InkWell(splashColor:Colors.transparent,onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>
          PlaceDetailsScreen(item:item,type:'Favorite Place',)))
        },child: Container(margin:const EdgeInsets.only(right:14),width:200,
              // width:MediaQuery.sizeOf(context).width*0.50,
            child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child: DImage(item.image??'', fit: BoxFit.cover,),
            ))),
        Align(alignment:Alignment.topRight,child: InkWell(onTap:() {
          // model.places!.mapIndexed((i, element){
          //   if(index==i){element.isFavourite=!element.isFavourite;}
          // }).toList();
          item.isFavourite=!item.isFavourite;setState(() {});
        },child: Container(margin:const EdgeInsets.only(top:14,left:14),padding:const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Constants.white,shape: BoxShape.circle),child:
            Icon(Icons.favorite,color:(item.isFavourite??false)?Constants.red:Constants.black.withOpacity(0.6),),
          ),
        )),
        Align(alignment: Alignment.bottomLeft,
            child: Padding(padding: const EdgeInsets.only(left:14,bottom:14),
              child: Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children: [
                DText(title:item.name??'', size:PSize.large,fontColor:Constants.white,fontWeight:FontWeight.w700,),
                Row(children:[const DImage('location'),const Padding(padding:EdgeInsets.symmetric(horizontal:2)),
                    DText(title:item.location??'', size:PSize.small,fontColor:Constants.white,fontWeight:FontWeight.w400),
                  ],
                ),
                Row(children:[
                  RatingBarIndicator(
                  rating:item.rate??0,
                  itemBuilder: (context, index) => const Icon(Icons.star,color:Constants.yellow),
                  itemCount:5,itemSize: 16.0,
                ),const Padding(padding:EdgeInsets.symmetric(horizontal:2)),
                    DText(title:'${item.rate??0}', size:PSize.small,fontColor:Constants.white,fontWeight:FontWeight.w500),
                    // DText(title:'${item['price']} \$', size:PSize.small,fontColor:Constants.white,fontWeight:FontWeight.w400),
                  ],
                ),
                ],
              ),
            )),
      ],
    );
  }

  Widget popularChild({required Places item}){
    return  Container(margin:const EdgeInsets.only(top:20),height:175,
      child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:<Widget>[
        Expanded(flex:2,
          child: InkWell(splashColor:Colors.transparent,onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>
                PlaceDetailsScreen(item:item,type:'Popular Place',)))
          },child: Container(margin:const EdgeInsets.only(right:14),
                  child: ClipRRect(borderRadius: BorderRadius.circular(20),
                    child: DImage(item.image??'', fit: BoxFit.cover,),
                  ))),
        ),
        Expanded(flex:3,
          child: Padding(padding: const EdgeInsets.symmetric(vertical:14),
            child: Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children: [
              Row(mainAxisSize:MainAxisSize.max,crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  DText(title:item.name??'', size:PSize.large,fontWeight:FontWeight.w700,),
                InkWell(onTap:() {
                  // model.places!.mapIndexed((i, element){
                  //   if(index==i){element.isFavourite=!element.isFavourite;
                  // }).toList();
                  item.isFavourite=!item.isFavourite;setState(() {});
                },child: Icon((item.isFavourite??false)?Icons.favorite:Icons.favorite_border,color:(item.isFavourite??false)?Constants.red:Constants.black.withOpacity(0.4),)),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top:10),
                child: DText(title:'${item.price??0} \$', size:PSize.small,fontColor:Constants.red,fontWeight:FontWeight.w400),
              ),
              Row(children:[
                RatingBarIndicator(
                  rating:item.rate??0,
                  itemBuilder: (context, index) => const Icon(Icons.star,color:Constants.yellow),
                  itemCount:5,itemSize: 16.0,
                ),const Padding(padding:EdgeInsets.symmetric(horizontal:2)),
                DText(title:'${item.rate??0}', size:PSize.small,fontWeight:FontWeight.w500),
              ]),
              Padding(padding: const EdgeInsets.only(top:10),
                child: DText(title:'${item.description??''} \$',maxLines:4,overflow:TextOverflow.ellipsis,
                    size:PSize.small,fontColor:Constants.black,fontWeight:FontWeight.w200),
              ),
            ],
            ),
          ),
        ),
      ],
      ),
    );
  }
}