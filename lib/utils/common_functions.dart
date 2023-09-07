import 'dart:convert';
import 'package:diverge_task/core/data/model/home/place_response_model.dart';
import 'package:diverge_task/utils/place_data.dart';
import 'package:image_picker/image_picker.dart';

PlacesResponseModel getDataModel(){
  PlacesResponseModel model = PlacesResponseModel.fromJson(jsonDecode(PlacesData().data));
  return model;
}

Future<XFile> getImage() async {
  final ImagePicker imgpicker = ImagePicker();
  var pickedFile;
  try {
     pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {

    } else {
      print("No image is selected.");
    }
  } catch (e) {
    print("error while picking image.");
  }
  return pickedFile;
}