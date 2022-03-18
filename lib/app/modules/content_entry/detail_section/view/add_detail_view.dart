import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/app_exports.dart';
import '../controller/add_update_detail_controller.dart';

class AddUpdateDetailView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AddUpdateDetailController>(
        init: AddUpdateDetailController(), 
        initState: AddUpdateDetailController().addBlankText(),       
        builder: (controller) {
        //   List<TextEditingController> name1 =
        // List.generate(9, (i) => TextEditingController(text: controller.detailData.string[i]));
          return Padding(
            padding:  EdgeInsets.only(left:Get.width*0.05,right: Get.width*0.05,top: Get.height*0.05),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                          "Detail edit/update zone",
                          style: context.theme.textTheme.headline3,
                        ),
                        SizedBox(height: 20,),
                  Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('PujaPurohitFiles/commonCollections/deatil').snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.data==null){
                                return const Center(child: Text('Loading...'),);
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.size,
                                shrinkWrap: true,
                                itemBuilder: (_,index){
                                  return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.docs[index]['image']),                                                    
                                ),
                                title: Text(snapshot.data!.docs[index]['name1'][0]),
                              );
                                });
                            }
                          )),
                  
                          Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              TextButton(onPressed: (){
                                //print(controller.detailData.value.begin1);
                              }, child: Text("Add new")),
                            ],
                          ))
                          
                          ]
                  ),
                ],
              ),
            ),
          ); 
        },
      
      ),
    );
  }

}