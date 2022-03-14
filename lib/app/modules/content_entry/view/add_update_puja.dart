import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logging/logging.dart';
import 'package:management/main.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_exports.dart';
import 'package:management/resources/responshive.dart';
import '../../../../resources/app_strings.dart';

class AddUpdatePuja extends StatelessWidget {
  String tab = Get.parameters['tab']!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.2),
                    child: Column(
                      children: [      
                         MenuBarTile(
        selectedTab: 'up',
        iconData: LineIcons.fileUpload,
        titleText: 'Update Puja',
        tab: tab,
        onTap: () {
          Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/up');
        },
      ),
       MenuBarTile(
        selectedTab: 'an',
        iconData: LineIcons.newspaper,
        titleText: 'Add New Puja',
        tab: tab,
        onTap: () {
          Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/an');
        },
      ),
       MenuBarTile(
        selectedTab: 'rp',
        iconData: LineIcons.recycle,
        titleText: 'Remove Puja',
        tab: tab,
        onTap: () {
          Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/rp');
        },
      ),
],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Container(
                    margin: EdgeInsets.only(top: Get.height * .1),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('/assets_folder/puja_ceremony_folder/folder').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Widget> _pujaCards = [];
                          snapshot.data!.docs.forEach((element) {
                            _pujaCards.add(PujaCards(
                              text: element['puja_ceremony_name'][0],
                              iconData: element['puja_ceremony_display_picture'],
                              remove: false,
                              ontap: () async {
                                await FirebaseAnalytics.instance.logEvent(
                                  name: "update_puja",
                                  parameters: {
                                    "pujaname": element['puja_ceremony_name'][0],
                                  },
                                );
                              },
                            ));
                          });
                          if (tab == 'up') {
                            return Wrap(
                              direction: Axis.horizontal,
                              children: _pujaCards,
                            );
                          } else if (tab == 'an') {
                            return AddNewPuja();
                          }
                          return SizedBox();
                        })),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddNewPuja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _name = List.generate(11, (i) => TextEditingController());
    TextEditingController keyword = TextEditingController();
    return Padding(
      padding: ResponsiveWidget.isSmallScreen(context) ? EdgeInsets.all(0) : EdgeInsets.only(left: Get.width * 0.15, right: Get.width * 0.15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ExpandablePanel(
                header: addPujaTextField(_name[0], "Puja Name English"),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    addPujaTextField(_name[1], "Puja Name Hindi"),
                    addPujaTextField(_name[2], "Puja Name Bengali"),
                    addPujaTextField(_name[3], "Puja Name Tamil"),
                    addPujaTextField(_name[4], "Puja Name Telugu"),
                    addPujaTextField(_name[5], "Puja Name Marathi"),
                    addPujaTextField(_name[6], "Puja Name Gujrati"),
                    addPujaTextField(_name[7], "Puja Name Odia"),
                    addPujaTextField(_name[8], "Puja Name Punjabi"),
                    addPujaTextField(_name[9], "Puja Name Kannad"),
                    addPujaTextField(_name[10], "Puja Name Malyali"),
                  ],
                )),
            ExpandablePanel(
              header: addPujaTextField(keyword, "Puja Keyword"),
              collapsed: const SizedBox(),
              expanded: SizedBox(),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                    contentPadding: EdgeInsets.all(20),
                    title: "Warning",
                    content: Text("Are you sure you want to remove ?"),
                    // confirm: Text("Confirm"),
                    // cancel:  Text("Cancel"),
                    onConfirm: () {},
                    onCancel: () {
                      Get.back();
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red, width: 2.0)),
                child: Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addPujaTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: hintText,

            //make hint text
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

Map modifyPuja(tab) => {
    };
