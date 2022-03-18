import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:management/app/modules/content_entry/upcoming_section/controller/add_upcoming_controller.dart';
import 'package:management/resources/app_components/custom_widgets.dart';
import 'package:management/resources/app_exports.dart';

class AddUpcomingView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController detail = TextEditingController();
    TextEditingController num = TextEditingController();
    String upcomingId =
    "UPID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
   return Scaffold(
     body: GetX<AddUpcomingController>(
       init: AddUpcomingController(),
       builder: (controller){
       return Column(
       children: [
          Container(
                    alignment: Alignment.topRight,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(controller.addUpcomingData.value.image)),
                    ),
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Alert"),
                                    content: const Text(
                                        "Are you sure that you want to update this picture?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            FileUploadInputElement input =
                                                FileUploadInputElement()
                                                  ..accept = 'image/*';
                                            FirebaseStorage fs =
                                                FirebaseStorage.instance;
                                            input.click();
                                            input.onChange.listen((event) {
                                              final file = input.files!.first;
                                              final reader = FileReader();
                                              reader.readAsDataUrl(file);
                                              reader.onLoadEnd
                                                  .listen((event) async {
                                                var snapshot = await fs
                                                    .ref(
                                                        'assets_folder/upcoming_events_folder')
                                                    .child('$upcomingId')
                                                    .putBlob(file);
                                                String downloadUrl =
                                                    await snapshot.ref
                                                        .getDownloadURL();
                                                  controller.updateImage(downloadUrl);      
                                               
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Continue")),
                                    ],
                                  ));
                        },
                        child: Text("Edit")),
                  ),

                  addCustomTextField(name, 'Event Name'),
                  addCustomTextField(detail, 'Event detail Location'),
                  addCustomTextField(num, 'Event position'),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                     Get.defaultDialog(
                       middleText: "Are you sure you want to add ${name.text} as upcoming event",
                       onConfirm: (){
                        if(name.text.isEmpty || detail.text.isEmpty || num.text.isEmpty){
                          Get.showSnackbar(const GetSnackBar(titleText: Text(''),messageText: Text('Please fill are fields properly'),duration: Duration(seconds: 2),));
                        }
                        else{
                     FirebaseFirestore.instance.doc('/PujaPurohitFiles/commonCollections/upcoming/$upcomingId').set({
                        'name' : name.text,
                        'detail' : detail.text,
                        'image' : controller.addUpcomingData.value.image,
                        'nick' : name.text,
                        'end' :'',
                        'duration' :'',
                        'date':'',
                        'keyword' : detail.text,
                        'link' : detail.text,
                        'muhrat': '', 
                        'color':'',
                        'begin':'',
                        'num': int.parse(num.text)
                      }).whenComplete(() {
                        Get.back();
                      });
                        }
                       },
                       onCancel: (){
                         Get.back();
                       }
                     );
                    },
                    child: redButton('Submit'))
       ],
     );
   
     },)
   );
  }

}