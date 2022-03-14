import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/app/modules/management/controller/pandit_controller.dart';
import 'package:management/resources/app_exports.dart';

class PujaOffering extends StatefulWidget{
  final AsyncSnapshot<DocumentSnapshot> asyncSnapshot;
 const PujaOffering({required this.asyncSnapshot});

  @override
  State<PujaOffering> createState() => _PujaOfferingState();
}

class _PujaOfferingState extends State<PujaOffering> {
  String enableId = '';
  @override
  Widget build(BuildContext context) {
    return GetX<PanditServiesController>(
      init: PanditServiesController(),
      builder: (controller){
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                if(controller.panditServiceData.value.add){
                  controller.panditServiceData.update((val) {
                    val!.add = false;
                  });                
                 List<Map<String , dynamic>>  pujas= [];
                controller.allPujas.value.forEach((element) {
                   if(element['selected']==true){
                     pujas.add({
                       'puja_ceremony_id':element['id'],
                       'puja_ceremony_keyword':element['keyword'],
                       'puja_ceremony_details':'',
                       'puja_ceremony_time':element['duration'],
                       'puja_ceremony_price':element['price'],
                       'puja_ceremony_subscriber':0,
                       'puja_ceremony_swastik_gain':0
                     });
                   }
                 });                
                 for (var element in pujas) {
                   FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services/${element['puja_ceremony_id']}').set(element);
                 }
                      
                }
                else{
                   controller.panditServiceData.update((val) {
                    val!.add = true;                    
                  });
                  
                }
              }, child: Text(controller.panditServiceData.value.add? "Save":"Add New"))
            ],
          ),
          SizedBox(
            height: 10,
          ),
            controller.panditServiceData.value.add? addServices(controller):editServices(),
              ],
            ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> editServices() {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(
                  '/users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data!.docs;
            List<Widget> pooja = [];
            for (var mess in data) {
              final String? name = mess['puja_ceremony_keyword'];
              final dynamic price = mess['puja_ceremony_price'];
              final String? duration = mess['puja_ceremony_time'];
              final String? id = mess['puja_ceremony_id'];
              final subscriber = mess['puja_ceremony_subscriber'];
              final String? docId = mess.id;
              final messagewidget = pujaoffering(
                name,
                price,
                duration,
                subscriber,
                id,
                docId,
              );
              pooja.add(messagewidget);
            }
            return ListView(
              children: pooja,
              shrinkWrap: true,
            );
          });
  }

 Widget addServices(PanditServiesController controller) {
    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.allPujas.value.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 200,
                                child: ListTile(                                
                                  leading: Checkbox(
                                      value: controller.allPujas.value[index]
                                          ['selected'],
                                      onChanged: (value) {
                                        controller.allPujas.update((val) {
                                          val![index]['selected'] = value;
                                        });
                                      }),                               
                                  title: Text(
                                    "${controller.allPujas.value[index]['name']}",
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        hintText: controller
                                            .allPujas.value[index]['duration']),
                                    onChanged: (value) {
                                      controller.allPujas.update((val) {
                                        val![index]['duration'] = value;
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        hintText: controller
                                            .allPujas.value[index]['price']),
                                    onChanged: (value) {
                                      controller.allPujas.update((val) {
                                        val![index]['price'] = value;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          );
                        });
  }
  Widget pujaoffering(name,price, duration,subscriber,pujaId,docId) {
    TextEditingController newPrice = TextEditingController(text: price.toString());
    TextEditingController newTime = TextEditingController(text: duration.toString());
    
    return Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          CircleAvatar(
             backgroundColor: Colors.orangeAccent,
             child: Text(
               '$subscriber',
               style: const TextStyle(
                   fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
             ),
           ),
           Text(name),
           SizedBox(
             width: 100,
             child: TextFormField(
               enabled: docId==enableId?true:false,
               controller: newPrice,
               style: const TextStyle(fontSize: 12,),
               decoration:const InputDecoration(
                 border: InputBorder.none,
                 prefixIcon: Icon(LineIcons.indianRupeeSign,size: 12,)
               ),
               ),
           ),
           SizedBox(
             width: 40,
             child: TextFormField(
               enabled: docId==enableId?true:false,
               controller: newTime,
               style: const TextStyle(fontSize: 12,),
               decoration:const InputDecoration(
                 border: InputBorder.none,               
               ),
               ),
           ), 
                 
          const SizedBox(height:20),
          TextButton(onPressed: ()async{          
            if(enableId==docId){
             await FirebaseFirestore.instance.doc('/users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services/$docId').update({
                'puja_ceremony_price':double.parse(newPrice.text),
                'puja_ceremony_time': newTime.text
              }).whenComplete((){
              setState(() {
                enableId = '';
              });
              //  html.window.location.reload();
              });
             
            }       
             else{
                setState(() {
                enableId = docId;
              });
             }
          }, child: Text(docId==enableId?"Save":"Edit", style: TextStyle(fontSize: 12,color: Get.isDarkMode?Colors.white:Colors.black87))),
          SizedBox(width: 10,),
          SizedBox(
             child: TextButton(onPressed: (){
               FirebaseFirestore.instance.doc('/users_folder/folder/pandit_users/${widget.asyncSnapshot.data!['pandit_uid']}/pandit_ceremony_services/$docId').delete();
             }, child: Text("Delete",style:TextStyle(color: Colors.redAccent))),
           ),
        ],
      );
  }
}

