import 'package:dio/dio.dart';
import 'package:diverge_task/Bloc/place_details_bloc/place_details_cubit.dart';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:diverge_task/custom/d_button.dart';
import 'package:diverge_task/custom/d_image.dart';
import 'package:diverge_task/custom/d_text.dart';
import 'package:diverge_task/custom/image_view.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Places item;
  final String type;
  const PlaceDetailsScreen({super.key, required this.item,required this.type});
  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  int? statusCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Constants.white,
      body:body()
    );
  }
  Widget body(){
    return Padding(
      padding: const EdgeInsets.only(top:60,left:24,right:24,bottom:14),
      child: Column(
        children: [
          Expanded(flex:9,
            child: SingleChildScrollView(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
              SizedBox(height:280,
                child: Stack(children: [
                  InkWell(onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ImageView(
                        parentUrl:widget.item.image??'',index:0,urls:widget.item.subImages)));
                  },
                    child: ClipRRect(borderRadius: BorderRadius.circular(20),
                      child: SizedBox(width:MediaQuery.sizeOf(context).width,child: DImage(widget.item.image??'',fit:BoxFit.cover,width:
                      MediaQuery.sizeOf(context).width,height:280,)),
                    ),
                  ),
                  Align(alignment:Alignment.topCenter,child: Padding(padding: const EdgeInsets.all(14),
                    child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
                      InkWell(onTap:() {Navigator.pop(context);},child:const DImage('arrow_left')),
                      InkWell(onTap:() {Navigator.push(context, MaterialPageRoute(builder: (context) =>  ImageView(
                          parentUrl:widget.item.image??'',index:0,urls:widget.item.subImages)));},child:const DImage('maximize')),
                    ],),
                  )),
                  if(widget.item.subImages!=null&&widget.item.subImages!.isNotEmpty)
                    Align(alignment:Alignment.bottomCenter,child:Container(decoration:BoxDecoration(
                        color:Constants.black.withOpacity(0.5),borderRadius:const BorderRadius.all(Radius.circular(10))
                    ),margin:const EdgeInsets.only(left:16,right:16,bottom:24),
                        width: double.infinity,height:70,child: ListView.builder(padding:EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,itemCount: widget.item.subImages!.take(4).length,
                            itemBuilder: (context, index) {
                              return SizedBox(width:75,height:70,child: Stack(fit:StackFit.expand,children: [
                                ColorFiltered(colorFilter: ColorFilter.mode((index==widget.item.subImages!.take(4).length-1&& widget.item.subImages!.length > 4)?Colors.black.withOpacity(0.6):Colors.transparent, BlendMode.darken),
                                  child: Padding(padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(6),child:InkWell(onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ImageView(
                                          index:index,urls:widget.item.subImages!)));
                                    },child: DImage(widget.item.subImages![index],width:60,height:60,fit:BoxFit.cover,)),),
                                  ),
                                ),
                                if(index== widget.item.subImages!.take(4).length-1&& widget.item.subImages!.length > 4) InkWell(onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ImageView(
                                      index:3,urls:widget.item.subImages!)));
                                },child: Center(child:DText(title:" +${widget.item.subImages!.length - 4}",size:PSize.veryLarge,
                                  fontColor:Constants.white,fontWeight:FontWeight.w800,)),
                                ),
                              ]));
                            })),)
                ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical:16),
                child: Row(children: [
                  const DImage('verify',width:22,height:22,),const Padding(padding:EdgeInsets.symmetric(horizontal:4)),
                  DText(title:widget.type, size: PSize.large,fontWeight:FontWeight.w300,)
                ],
                ),
              ),
              DText(title:widget.item.name??'', size: PSize.doubleLarge,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:14),
                child: Row(children:[ DImage('location',width:22,height:22,color:Constants.black.withOpacity(0.6)),const Padding(padding:EdgeInsets.symmetric(horizontal:2)),
                  DText(title:widget.item.location??'', size:PSize.small,fontWeight:FontWeight.w300),
                ],
                ),
              ),
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                RichText(text:TextSpan(
                    text:'+${widget.item.lovedPeople?.length??0} ',
                    style:const TextStyle(color:Constants.black,fontWeight:FontWeight.w500,fontSize:18),
                    children:const [
                      TextSpan(text:'people love this place', style:TextStyle(color:Constants.black,fontWeight:FontWeight.w300,fontSize:14))])),
                Stack(children: List<Widget>.generate(widget.item.lovedPeople!.length, (index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(index.toDouble() * 10.0, 0, 0, 0),
                    child:ClipOval(child:SizedBox.fromSize(size:const Size.fromRadius(15), child: DImage(widget.item.lovedPeople![index].image??''))),
                  );
                })),
              ],),
              Row(children:[
                RatingBarIndicator(
                  rating:widget.item.rate??0,
                  itemBuilder: (context, index) => const Icon(Icons.star,color:Constants.yellow),
                  itemCount:5,itemSize: 16.0,
                ),const Padding(padding:EdgeInsets.symmetric(horizontal:2)),
                DText(title:'${widget.item.rate??0}', size:PSize.small,fontWeight:FontWeight.w500),
              ]),
              Padding(
                padding: const EdgeInsets.only(top:24),
                child: DText(title:'${widget.item.description??''} \$',size:PSize.small,fontColor:Constants.black,fontWeight:FontWeight.w300),
              ),
            ]),
            ),
          ),

          Expanded(
            child: Align(alignment: FractionalOffset.bottomCenter,
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                RichText(text:TextSpan(
                    text:'${widget.item.price??0} \$ ',
                    style:const TextStyle(color:Constants.black,fontWeight:FontWeight.w500,fontSize:18),
                    children:const [
                      TextSpan(text:'/person', style:TextStyle(color:Constants.black,fontWeight:FontWeight.w300,fontSize:12))])),

                statusCode==null||statusCode==200||statusCode==201?
                SizedBox(width:110, child: DButton(onPressed:() async {
                  setState(() {
                    statusCode=1;
                  });
                 Response response= await PlaceDetailsCubit.get(context).getBookingAPi();
                  Future.delayed(const Duration(seconds:1), () {
                    statusCode=response.statusCode;
                    setState(() {});
                    Navigator.pop(context);
                  });
                },title:'Booking',style:PStyle.tertiary,fillColor:Constants.sky,textColor:Constants.white),
                ):const CircularProgressIndicator()
              ],),
            ),
          )
        ],
      ),
    );
  }
}