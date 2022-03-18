import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:management/resources/app_exports.dart';

class AddUpcomingController extends GetxController{
  var addUpcomingData = AddUpcomingData(image: 'https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png').obs;
  updateImage(String imgUrl){
    addUpcomingData.update((val) {
      val!.image = imgUrl;
    });
  }

}

class AddUpcomingData{
  String image;
  AddUpcomingData({required this.image});
}

