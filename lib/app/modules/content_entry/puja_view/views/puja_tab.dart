import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:management/app/modules/content_entry/puja_view/controller/puja_add_controller.dart';
import 'package:management/app/modules/content_entry/puja_view/views/update_puja.dart';
import 'package:management/app/modules/content_entry/samagri_section/view/samagri_add_delete.dart';
import 'package:management/resources/app_components/function_cards.dart';
import 'package:management/resources/app_components/menu_bar_tiles.dart';
import 'package:management/resources/app_config.dart';
import 'package:management/resources/app_exports.dart';
import '../../../../../resources/app_strings.dart';
import 'add_new_puja.dart';

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
                          titleText: 'Add Puja',
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
                              remove: tab == 'rp' ? true : false,
                              text: element['puja_ceremony_name'][0],
                              deleteOntap: () {
                                // showDialog( context: context,
                                //   builder: (context) => AlertDialog(
                                Get.dialog(
                                    FractionallySizedBox(
                                      heightFactor: 0.05,
                                      widthFactor: 0.2,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final id = await FirebaseFirestore.instance
                                              .collection('/analytics_folder/folder/management_analytics/puja/delete/')
                                              .add({
                                            "puja_name": element['puja_ceremony_name'],
                                            "puja_id": element['puja_ceremony_id'],
                                            'time_stamp': FieldValue.serverTimestamp()
                                          });

                                          print(id);
                                          FirebaseFirestore.instance
                                              .doc('assets_folder/puja_ceremony_folder/folder/${element['puja_ceremony_id']}')
                                              .delete();

                                          print("delete called");
                                          Get.back();
                                        },
                                        child: Text("Confirm"),
                                      ),
                                    ),
                                    useSafeArea: false);
                              },
                              iconData: element['puja_ceremony_display_picture'],
                              ontap: () {
                                HomeController homeController = Get.put(HomeController());
                                homeController.samagriFetch();
                                homeController.fetchUpdateSamagri(element['puja_ceremony_id']);
                                homeController.fetchGodBenefit(element['puja_ceremony_id']);
                                Get.bottomSheet(
                                    Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        height: Get.height * 0.9,
                                        child: UpdatePuja(PujaData(
                                          element['puja_ceremony_keyword'],
                                          element['puja_ceremony_standard_price'],
                                          element['puja_ceremony_standard_duration'],
                                          element['puja_ceremony_id'],
                                          element['puja_ceremony_benefits_filter'],
                                          element['puja_ceremony_name'],
                                          element['puja_ceremony_description'],
                                        ))),
                                    backgroundColor: context.theme.backgroundColor,
                                    isScrollControlled: true);
                              },
                            ));
                          });
                          if (tab == 'up' || tab == 'rp') {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: _pujaCards,
                              ),
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
