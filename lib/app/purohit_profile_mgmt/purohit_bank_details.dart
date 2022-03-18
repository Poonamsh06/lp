import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:management/app/purohit_profile_mgmt/reusable_widgets.dart';
import 'package:management/app/reusable_widgets.dart';

class PurohitBankDetails extends StatelessWidget {
  final uid;

  const PurohitBankDetails({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tMKformKey = GlobalKey<FormState>();
    String? number = "";
    String? ifsc = "";
    String? name = "";
    String? bankName = "";
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.doc('users_folder/folder/pandit_users/$uid/pandit_credentials/pandit_bank_details').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.data!.exists) {
              return Center(
                child: Text("Not Exist"),
              );
            }

            number = snapshot.data!.get('pandit_bank_account_number') == null ? "" : snapshot.data!.get('pandit_bank_account_number');
            ifsc = snapshot.data!.get('pandit_bank_ifsc_code') == null ? "" : snapshot.data!.get('pandit_bank_ifsc_code');
            bankName = snapshot.data!.get('pandit_bank_name') == null ? "" : snapshot.data!.get('pandit_bank_name');
            name = snapshot.data!.get('pandit_name_on_bank') == null ? "" : snapshot.data!.get('pandit_name_on_bank');

            return Center(
              child: Form(
                key: _tMKformKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      onPress: (String? string) {
                        bankName = string;
                      },
                      lable: "Bank name",
                      initialText: bankName,
                    ),
                    CustomTextFormField(
                      onPress: (String? string) {
                        name = string;
                      },
                      lable: "Pandit name on bank",
                      initialText: name,
                    ),
                    CustomTextFormField(
                      onPress: (String? string) {
                        ifsc = string;
                      },
                      lable: "Pandit bank ifsc code",
                      initialText: ifsc,
                    ),
                    CustomTextFormField(
                      onPress: (String? string) {
                        number = string;
                      },
                      lable: "Pandit bank account number",
                      initialText: number,
                    ),
                    updateButton(() {
                      _tMKformKey.currentState!.save();
                      FirebaseFirestore.instance
                          .doc(
                              'users_folder/folder/pandit_users/$uid/pandit_credentials/pandit_bank_details')
                          .set({
                        'pandit_bank_account_number': number,
                        'pandit_bank_ifsc_code': ifsc,
                        'pandit_bank_name': bankName,
                        'pandit_name_on_bank': name
                      }).whenComplete(() => Navigator.of(context).pop());
                    }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
