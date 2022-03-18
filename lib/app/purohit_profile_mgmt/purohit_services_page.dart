import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_service_add_edit_form.dart';
import 'package:management/app/reusable_widgets.dart';
import 'package:management/main.dart';

import '../../resources/app_components/custom_searchable_dropdown.dart';

class PurohitServicesPage extends StatelessWidget {
  final uid;

  const PurohitServicesPage({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users_folder/folder/pandit_users/$uid/pandit_ceremony_services').snapshots(),
        builder: (context, ownPuja) {
          if (ownPuja.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('/assets_folder/puja_ceremony_folder/folder').snapshots(),
              builder: (context, snapshotT) {
                if (snapshotT.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DropdownMenuItem<String>> items = List<DropdownMenuItem<String>>.generate(
                    snapshotT.data!.docs.length,
                    (index) => DropdownMenuItem(
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => PurohitServiceAddAndEdit(
                                        id: snapshotT.data!.docs[index].id,
                                        time: snapshotT.data!.docs[index].get("puja_ceremony_standard_duration"),
                                        price: snapshotT.data!.docs[index].get("puja_ceremony_standard_price"),
                                        uid: uid,
                                        documentSnapshot: null,
                                        img: snapshotT.data!.docs[index].get("puja_ceremony_display_picture"),
                                        name: snapshotT.data!.docs[index].get("puja_ceremony_name")[0],
                                      ));
                            },
                            leading: Image.network("${snapshotT.data!.docs[index].get("puja_ceremony_display_picture")}"),
                            title: Text("${snapshotT.data!.docs[index].get("puja_ceremony_name")[0]}"),
                            subtitle: Text(snapshotT.data!.docs[index].id),
                          ),
                          value: snapshotT.data!.docs[index].get("puja_ceremony_name")[0] + snapshotT.data!.docs[index].id,
                        ));
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: [
                      Get.find<AuthDataController>().role.value.canUpdate()
                          ? SearchChoices.single(
                              items: items,
                              value: "",
                              onChanged: () {},
                              // label: "Search Pandit profile here by name",
                              underline: SizedBox(),
                              // isExpanded: true,
                              icon: const Text(
                                "Add Puja",
                                style: TextStyle(color: Colors.blue),
                              ),
                              //icon: Icon(Icons.description),
                              displayClearIcon: false,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  body: ListView.separated(
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .doc('assets_folder/puja_ceremony_folder/folder/${ownPuja.data!.docs[index].id}')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                const Center(
                                  child: Text("Loading"),
                                );
                              }

                              return ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => PurohitServiceAddAndEdit(
                                            uid: uid,
                                            documentSnapshot: ownPuja.data!.docs[index],
                                            img: snapshot.data!.get("puja_ceremony_display_picture"),
                                            name: snapshot.data!.get("puja_ceremony_name")[0],
                                          ));
                                },
                                leading: Image.network("${snapshot.data!.get("puja_ceremony_display_picture")}"),
                                title: Text("${snapshot.data!.get("puja_ceremony_name")[0]}"),
                                subtitle: Text(ownPuja.data!.docs[index].id),
                              );
                            });
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                      itemCount: ownPuja.data!.size),
                );
              });
        });
  }
}
