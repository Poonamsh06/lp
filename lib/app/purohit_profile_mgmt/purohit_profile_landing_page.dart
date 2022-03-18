import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_bank_details.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_basic_details_form.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_booking_details.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_services_page.dart';
import 'package:management/app/purohit_profile_mgmt/purohit_uidai_details.dart';
import 'package:management/main.dart';

class PurohitProfileLandingPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  RxInt currentPage = 1.obs;

  PurohitProfileLandingPage({
    required this.documentSnapshot,
  });

  @override
  build(BuildContext context) {
    return Obx(() => 
    Scaffold(
        appBar: AppBar(
          title: const Text("Purohit Dashboard"),
        ),
        // backgroundColor: Colors.white,
        drawer: Drawer(
          child: Column(
            children: [
              
              ...Get.find<AuthDataController>().role.value.displayPanditActions(currentPage)
            ]
          ),
        ),
        body: currentPage == 1
            ? PurohitBasicDetailsForm(
                documentSnapshot: documentSnapshot,
              )
            : currentPage == 2
                ? PurohitBankDetails(
                    uid: documentSnapshot.id,
                  )
                : currentPage == 3
                    ? PurohitUidaiDetails(
                        uid: documentSnapshot.id,
                      )
                    : currentPage == 5
                        ? PurohitServicesPage(
                            uid: documentSnapshot.id,
                          )
                        : currentPage == 6
                            ? const PurohitBookingDetails()
                            : const Center(child: Text("Nothing here"))));
  }
}

Map panditActions(currentPage) => {
      "Basic Details": ListTile(
        title: const Text("Basic Details"),
        onTap: () {
          currentPage.value = 1;
        },
      ),
      "Bank Details": ListTile(
        title: const Text("Bank Details"),
        onTap: () {
          currentPage.value = 2;
        },
      ),
      "UIDAI Details": ListTile(
        title: const Text("UIDAI Details"),
        onTap: () {
          currentPage.value = 3;
        },
      ),
      "Puja Ceremony Services Details": ListTile(
        title: const Text("Puja Ceremony Services Details"),
        onTap: () {
          currentPage.value = 5;
        },
      ),
      "Booking Details": ListTile(
        title: const Text("Booking Details"),
        onTap: () {
          currentPage.value = 6;
        },
      ),
    };
