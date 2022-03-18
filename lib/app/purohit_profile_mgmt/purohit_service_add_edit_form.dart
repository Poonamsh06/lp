import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/app/purohit_profile_mgmt/reusable_widgets.dart';
import 'package:management/app/reusable_widgets.dart';

class PurohitServiceAddAndEdit extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
  final name;
  final img;
  final uid;
  final id;
  final price;
  final time;

  const PurohitServiceAddAndEdit(
      {Key? key,
      required this.documentSnapshot,
      this.name,
      this.img,
      this.uid,
      this.id,
      this.price,
      this.time})
      : super(key: key);

  @override
  _PurohitServiceAddAndEditState createState() =>
      _PurohitServiceAddAndEditState();
}

class _PurohitServiceAddAndEditState extends State<PurohitServiceAddAndEdit> {
  final _njPFormKey = GlobalKey<FormState>();
  double price = 0.0;
  String time = "";
  String additionalDetails = "";

  @override
  void initState() {
    if (widget.documentSnapshot != null) {
      price = widget.documentSnapshot!.get("puja_ceremony_price");
      time = widget.documentSnapshot!.get("puja_ceremony_time");
      additionalDetails =
          widget.documentSnapshot!.get("puja_ceremony_details") ?? "";
    } else {
      price = widget.price ?? 500;
      time = widget.time ?? "2 Hours";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _njPFormKey,
          child: Column(
            children: [
              Image.network(
                widget.img,
                height: 300,
              ),
              Text("ID: ${widget.documentSnapshot==null?widget.id:widget.documentSnapshot!.id}"),
              Text("Name: ${widget.name}"),
              CustomTextFormField(
                lable: "Price",
                initialText: "${price.round()}",
                onPress: (value) {
                  price = double.parse(value);
                },
              ),
              CustomTextFormField(
                  lable: "Time",
                  initialText: "$time",
                  onPress: (value) {
                    time = value;
                  }),
              CustomTextFormField(
                  lable: "Additional details",
                  initialText: "$additionalDetails",
                  onPress: (value) {
                    additionalDetails = value;
                    
                  }),


updateButton(
() {
                    _njPFormKey.currentState!.save();
                    if(widget.documentSnapshot==null){
                      FirebaseFirestore.instance
                          .doc(
                          'users_folder/folder/pandit_users/${widget.uid}/pandit_ceremony_services/${widget.documentSnapshot==null?widget.id:widget.documentSnapshot!.id}')
                          .set({
                        'puja_ceremony_details': additionalDetails,
                        'puja_ceremony_time': time,
                        'puja_ceremony_price': price
                      });
                    }
                    else{
                      FirebaseFirestore.instance
                          .doc(
                          'users_folder/folder/pandit_users/${widget.uid}/pandit_ceremony_services/${widget.documentSnapshot==null?widget.id:widget.documentSnapshot!.id}')
                          .update({
                        'puja_ceremony_details': additionalDetails,
                        'puja_ceremony_time': time,
                        'puja_ceremony_price': price
                      });
                    }

                    print("$price $additionalDetails $time");
                    Navigator.of(context).pop();
                  }
)
            ],
          ),
        ),
      ),
    );
  }
}
