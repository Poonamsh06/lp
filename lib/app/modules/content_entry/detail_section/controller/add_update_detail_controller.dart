import 'package:management/resources/app_exports.dart';



class AddUpdateDetailController extends GetxController{
  var detailData = AddUpdateDetailData().obs;

  @override
  void onInit(){
    super.onInit();
    addBlankText();
    }
  addBlankText(){
   for(int i=0;i<10;i++){
     detailData.value.begin1!.add("");
     detailData.value.end1!.add("");
     detailData.value.name1!.add("");
     detailData.value.vikram1!.add("");
     detailData.value.date1!.add("");     
   }
  }

}

class AddUpdateDetailData{
  String? begin;
  List<String>? begin1;
  String? date;
  List<String>? date1;
  String? end;
  List<String>? end1;
  String? name;
  List<String>? name1;
  String? vikram;
  List<String>? vikram1;
  AddUpdateDetailData({this.begin,this.begin1,this.date,this.date1,this.end,this.end1,this.name,this.name1,this.vikram,this.vikram1});
}