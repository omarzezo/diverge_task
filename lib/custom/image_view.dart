import 'package:diverge_task/custom/d_appbar.dart';
import 'package:diverge_task/custom/d_image.dart';
import 'package:diverge_task/utils/constants.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key,this.urls, this.index = 0,this.parentUrl}) : super(key: key);

  final List<String>? urls;
  final int index;
  final String? parentUrl;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late int imageIndex = widget.index ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar:appBar(context:context),
        body: SizedBox(height:MediaQuery.sizeOf(context).height,
          child: Stack(alignment: Alignment.center,children: [
            Container(constraints: const BoxConstraints.expand(height:400,),
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child:widget.parentUrl!=null&&imageIndex==0?Center(child: DImage(widget.parentUrl!)):Center(child: DImage(widget.urls![imageIndex]))
            ),
            if(widget.urls != null && widget.urls!.length !=  1)    Positioned(
              left: 2,
              child: IconButton(
                splashRadius: 30,
                onPressed: () {if(imageIndex > 0)imageIndex = imageIndex - 1; setState(() {

                });},
                icon: const Icon(Icons.chevron_left,color:Constants.sky,size: 30),
              ),
            ),
            if(widget.urls != null && widget.urls!.length !=  1) Positioned(
              right: 2,
              child: IconButton(
                splashRadius: 30,
                onPressed: (){
                  if(imageIndex < widget.urls!.length-1) {
                    imageIndex = imageIndex + 1;
                  } else {
                    imageIndex = 0;
                  }setState(() {

                  });
                },
                icon: const Icon(Icons.chevron_right,color: Constants.sky,size: 30),
              ),
            ),
          ]
          ),
        ));
  }
}