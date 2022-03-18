import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_bank_details.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_basic_details_form.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_uidai_details.dart';
import 'package:management/resources/app_exports.dart';
import 'package:switcher/switcher.dart';

import 'pandit_gallery.dart';
import 'pandit_puja_offering.dart';
import 'pandit_setting.dart';

class PanditUserDetails extends StatelessWidget{
 String id = Get.parameters['id']!;

  PanditUserDetails({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: context.theme.backgroundColor
      ,
      body: FutureBuilder(
       future: FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/${id}').get(), 
       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) { 
         if(snapshot.data==null){
           return Center(child: SizedBox(
             height: 50,width: 50,
             child: CircularProgressIndicator(color: !Get.isDarkMode?Colors.white:Colors.black54,),
           ),);
         }
          return  DefaultTabController(length: 6, child: Scaffold(
              backgroundColor: context.theme.backgroundColor,
              appBar: AppBar(
                backgroundColor:Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                flexibleSpace: Container(                 
                ),
                actions: [
                  TabBar(
                    labelStyle: GoogleFonts.aBeeZee(color:Colors.white),
                    labelColor: Get.isDarkMode?Colors.white:Colors.black54,                  
                    indicatorColor: Colors.orangeAccent,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator:BubbleTabIndicator(
                      
                       indicatorHeight: 25.0,
                        indicatorColor: !Get.isDarkMode?Colors.white:Colors.black54,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                        // Other flags
                        // indicatorRadius: 1,
                        // insets: EdgeInsets.all(1),
                        // padding: EdgeInsets.all(10)
                    ),
                    tabs: const[
                      Tab(
                        text: 'Puja Offering',
                      ),
                      Tab(
                        text: 'Bank detail',
                      ),
                       Tab(
                        text: 'Addhar',
                      ),
                      Tab(
                        text: 'Gallery',
                      ),
                      Tab(
                        text: 'Bookings',
                      ),
                      Tab(
                        text: 'Actions',
                      )
                    ],
                  ),
                  CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const[
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 8),
                                blurRadius: 8)
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${snapshot.data!.get('pandit_display_profile')}"))),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.4,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage('${snapshot.data!.get('pandit_display_profile')}'),
                                  fit: BoxFit.fill
                                )),
                          ),
                         const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: SelectableText(
                                    '${snapshot.data!.get('pandit_name')}',
                                    style: TextStyle(fontSize: 20),
                                    autofocus: true,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              snapshot.data!.get('pandit_verification_status')!
                                  ? const Icon(
                                Icons.verified,
                               
                                size: 14,
                              )
                                  : const Icon(
                                Icons.verified,
                                color: Colors.grey,
                                size: 12,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                             const  Icon(
                                Icons.location_history,
                               
                                size: 14,
                              ),
                            const  SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'State : ${snapshot.data!.get('pandit_state')}',
                                  style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'City : ${snapshot.data!.get('pandit_city')}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Swastik : ${snapshot.data!['pandit_swastik']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SelectableText(
                            'Contact : ${snapshot.data!['pandit_mobile_number']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            autofocus: true,
                          ),
                          SelectableText(
                            'Uid : ${snapshot.data!['pandit_uid']}',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),                        
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 40,
                    // ),
                    Expanded(
                      flex: 4,
                      child: TabBarView(                            
                        children: [                              
                          PujaOffering(asyncSnapshot: snapshot),
                          PurohitBankDetails(uid: snapshot.data!['pandit_uid'],),
                          PurohitUidaiDetails(uid: snapshot.data!['pandit_uid']),
                          PurohitBasicDetailsForm(documentSnapshot: snapshot),
                          Icon(Icons.directions_bike),
                          PanditSetting(query: snapshot),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        );
        }
      ),
    );
  }}

