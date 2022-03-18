import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/resources/app_exports.dart';

import '../controller/pandit_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management/main.dart';
import 'package:management/resources/app_exports.dart';
import 'package:management/roles/admin.dart';
import 'package:management/roles/super_admin.dart';
import 'package:switcher/switcher.dart';

class PanditSetting extends StatelessWidget {
  final AsyncSnapshot<DocumentSnapshot> query;
  PanditSetting({required this.query});
  @override
  Widget build(BuildContext context) {
   
    return GetX<PanditSettingController>(
      init:  PanditSettingController(query: query),      
      builder: (controller){
        TextEditingController name = TextEditingController(text: controller.panditData.value.name);
        TextEditingController state = TextEditingController(text: controller.panditData.value.state);
        TextEditingController city = TextEditingController(text: controller.panditData.value.city);
        TextEditingController qualification = TextEditingController(text: controller.panditData.value.qualification);
        TextEditingController mobile = TextEditingController(text: controller.panditData.value.number);
        TextEditingController email = TextEditingController(text: controller.panditData.value.email);
        TextEditingController experience = TextEditingController(text: controller.panditData.value.exp);
        TextEditingController bio = TextEditingController(text: controller.panditData.value.bio);
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width*0.15
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                if(controller.panditData.value.edit==true){
                   controller.panditData.update((val) {
                    val!.edit = false;
                  });

                  FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${query.data!['pandit_uid']}').update({
                      'pandit_verification_status':controller.panditData.value.verification,
                      'pandit_name':name.text,
                      'pandit_bio':bio.text,
                      'pandit_qualification':qualification.text,
                      'pandit_mobile_number':mobile.text ,
                      'pandit_state':state.text,        
                       'pandit_city': city.text,
                        'pandit_email':email.text                  
                  });
                }
                else{
                  controller.panditData.update((val) {
                    val!.edit = true;
                  });
                }
              }, child: Text(controller.panditData.value.edit?"Save":"Edit" ))
            ],
          ),
          ListTile(
            title:  Text(
                  'Verification',  
                ),
                trailing:  Switch(
                    value: controller.panditData.value.verification,                
                    onChanged: (bool state) {
                      
                      controller.updateVerification(state);          
                    },
                  ),
          ),
           ListTile(
            title: const Text(
                  'Name',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: name,
                  ),
                )
                  
          ),
          ListTile(
            title: const Text(
                  'State',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: state,
                  ),
                )
                  
          ),
          ListTile(
            title: const Text(
                  'City',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: city,
                  ),
                )
                  
          ),
           ListTile(
            title: const Text(
                  'Qualification',  
                ),
                trailing: SizedBox(
                  
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: qualification,
                  ),
                )
                  
          ),
           ListTile(
            title: const Text(
                  'Experience',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: experience,
                  ),
                )
                  
          ),
           ListTile(
            title: const Text(
                  'Mobile',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: mobile,
                  ),
                )
                  
          ),    
          ListTile(
            title: const Text(
                  'Email',  
                ),
                trailing: SizedBox(
                  width: 200,
                  child: TextFormField(
                    enabled: controller.panditData.value.edit,
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: email,
                  ),
                )
                  
          ),    
          ListTile(
            title: const Text(
                  'Bio',  
                ),
                trailing: SizedBox(  
                  width: 250, 
                  height: 100,             
                  child: TextFormField( 
                    enabled: controller.panditData.value.edit,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,                   
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ) ,
                   controller: bio,
                  ),
                )
                  
          ),     
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Get.defaultDialog(
                  contentPadding: EdgeInsets.all(20),
                  title: "Warning",
                  content: Text("Are you sure you want to remove ${query.data!['pandit_name']} ?"),                  
                  onConfirm: (){
                    FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${query.data!['pandit_uid']}').delete();
                    Get.back();
                    Get.back();
                  },
                  onCancel: (){Get.back();}
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red,width: 2.0)
                ),
                child: Text("Delete Account"),
              ),
            )
          ],
        )
    ]),
      );
    });
  }

}
