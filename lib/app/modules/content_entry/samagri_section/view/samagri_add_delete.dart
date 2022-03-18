import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/app/reusable_widgets.dart';
import 'package:management/resources/app_components/custom_widgets.dart';
import 'package:management/resources/app_exports.dart';

class SamagriAddDelete extends StatefulWidget {
  @override
  State<SamagriAddDelete> createState() => _SamagriAddDeleteState();
}

class _SamagriAddDeleteState extends State<SamagriAddDelete> {
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _newName = List.generate(11, (i) => TextEditingController());
    List<Widget> _newNameTextFields = List.generate(
      11,
      (index) => addSamagriTextField(_newName[index], "Samagri Name $index"),
    );
    List<TextEditingController> _newDescription = List.generate(11, (i) => TextEditingController());
    List<Widget> _newDescriptionTextFields = List.generate(
      11,
      (index) => addSamagriTextField(_newDescription[index], "Samagri Description $index"),
    );
    String sId =
        "SID${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}";
    TextEditingController newSamagriPrice = TextEditingController();
    TextEditingController newSamagriMargin = TextEditingController();
    SamagriController samagriController = Get.put(SamagriController());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    children: [
                      Text(
                        "Samagri edit zone",
                        style: context.theme.textTheme.headline3,
                      ),
                      Spacer(),
                      superAdminActionButton(() {
                        Get.bottomSheet(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                              height: Get.height * 0.9,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: _newNameTextFields,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: _newDescriptionTextFields,
                                            ))
                                      ],
                                    ),
                                    addSamagriTextField(newSamagriPrice, "Standard Price"),
                                    addSamagriTextField(newSamagriMargin, "Samagri margin"),
                                    InkWell(
                                      onTap: () {
                                        List<String> names = [];
                                        List<String> description = [];
                                        _newName.forEach((element) {
                                          names.add(element.text);
                                        });
                                        _newDescription.forEach((element) {
                                          description.add(element.text);
                                        });

                                        FirebaseFirestore.instance.doc('assets_folder/puja_items_folder/folder/$sId}').update({
                                          'puja_item_description': FieldValue.arrayUnion(description),
                                          'puja_item_name': FieldValue.arrayUnion(names),
                                          'puja_item_price': newSamagriPrice.text,
                                          'puja_item_margin': newSamagriMargin.text,
                                          'puja_item_vendors': [],
                                          'puja_item_display_picture':
                                              'https://i.etsystatic.com/18640148/r/il/89d229/2073623160/il_794xN.2073623160_nq7m.jpg'
                                        });
                                        Get.showSnackbar(const GetSnackBar(
                                          message: 'Updated samgri',
                                          duration: Duration(seconds: 2),
                                        ));
                                      },
                                      child: redButton("update"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            backgroundColor: context.theme.backgroundColor,
                            isScrollControlled: true);
                      }, 'Add New'),

                      // TextButton(
                      //     onPressed:                          child: const Text("Add New"))
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("assets_folder/puja_items_folder/folder").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ListView.builder(
                            semanticChildCount: 10,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (_, index) {
                              List<TextEditingController> _name =
                                  List.generate(5, (i) => TextEditingController(text: snapshot.data!.docs[index]['puja_item_name'][i]));
                              List<Widget> _nameTextFields = List.generate(
                                5,
                                (index) => addSamagriTextField(_name[index], "Samagri Name $index"),
                              );

                              List<TextEditingController> _description =
                                  List.generate(5, (i) => TextEditingController(text: snapshot.data!.docs[index]['puja_item_description'][i]));
                              List<Widget> _descriptionTextFields = List.generate(
                                5,
                                (index) => addSamagriTextField(_description[index], "Puja Description $index"),
                              );

                              TextEditingController samagriPrice = TextEditingController(text: snapshot.data!.docs[index]['puja_item_price']);
                              TextEditingController samagriMargin = TextEditingController(text: snapshot.data!.docs[index]['puja_item_margin']);
                              return ExpansionTile(
                                title: Text("${snapshot.data!.docs[index]['puja_item_name'][0]}"),
                                trailing: const Text("Edit"),
                                onExpansionChanged: (value) {
                                  snapshot.data!.docs.toList().forEach((element) {
                                    samagriController.samagriName
                                        .add(TextEditingController(text: "${snapshot.data!.docs[index]['puja_item_name'][index]}"));
                                  });
                                },
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: _nameTextFields,
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: _descriptionTextFields,
                                          ))
                                    ],
                                  ),
                                  addSamagriTextField(samagriPrice, "Standard Price"),
                                  addSamagriTextField(samagriMargin, "Samagri margin"),
                                  updateButton(() {
                                    List<String> names = [];
                                    List<String> description = [];
                                    _name.forEach((element) {
                                      names.add(element.text);
                                    });
                                    _description.forEach((element) {
                                      description.add(element.text);
                                    });

                                    FirebaseFirestore.instance
                                        .doc('assets_folder/puja_items_folder/folder/${snapshot.data!.docs[index]['puja_item_id']}')
                                        .update({
                                      'puja_item_description': FieldValue.arrayUnion(description),
                                      'puja_item_name': FieldValue.arrayUnion(names),
                                      'puja_item_price': samagriPrice.text,
                                      'puja_item_margin': samagriMargin.text
                                    });
                                    Get.showSnackbar(GetSnackBar(
                                      message: 'Updated samgri',
                                      duration: Duration(seconds: 2),
                                    ));
                                  }),
                                ],
                              );
                            });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addSamagriTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 10, // allow user to enter 5 line in textfield
          keyboardType: TextInputType.multiline,
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
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

class SamagriController extends GetxController {
  RxList<TextEditingController> samagriName = <TextEditingController>[].obs;
}
