import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../resources/app_exports.dart';

class HomeController extends GetxController {


  final List<Map<String, dynamic>> states = [
    {"code": "AN", "name": "Andaman and Nicobar Islands"},
    {"code": "AP", "name": "Andhra Pradesh"},
    {"code": "AR", "name": "Arunachal Pradesh"},
    {"code": "AS", "name": "Assam"},
    {"code": "BR", "name": "Bihar"},
    {"code": "CG", "name": "Chandigarh"},
    {"code": "CH", "name": "Chhattisgarh"},
    {"code": "DH", "name": "Dadra and Nagar Haveli"},
    {"code": "DD", "name": "Daman and Diu"},
    {"code": "DL", "name": "Delhi"},
    {"code": "GA", "name": "Goa"},
    {"code": "GJ", "name": "Gujarat"},
    {"code": "HR", "name": "Haryana"},
    {"code": "HP", "name": "Himachal Pradesh"},
    {"code": "JK", "name": "Jammu and Kashmir"},
    {"code": "JH", "name": "Jharkhand"},
    {"code": "KA", "name": "Karnataka"},
    {"code": "KL", "name": "Kerala"},
    {"code": "LD", "name": "Lakshadweep"},
    {"code": "MP", "name": "Madhya Pradesh"},
    {"code": "MH", "name": "Maharashtra"},
    {"code": "MN", "name": "Manipur"},
    {"code": "ML", "name": "Meghalaya"},
    {"code": "MZ", "name": "Mizoram"},
    {"code": "NL", "name": "Nagaland"},
    {"code": "OR", "name": "Odisha"},
    {"code": "PY", "name": "Puducherry"},
    {"code": "PB", "name": "Punjab"},
    {"code": "RJ", "name": "Rajasthan"},
    {"code": "SK", "name": "Sikkim"},
    {"code": "TN", "name": "Tamil Nadu"},
    {"code": "TS", "name": "Telangana"},
    {"code": "TR", "name": "Tripura"},
    {"code": "UK", "name": "Uttarakhand"},
    {"code": "UP", "name": "Uttar Pradesh"},
    {"code": "WB", "name": "West Bengal"}
  ];
  final List<Map<String, dynamic>> allSamagris = [];
  final Rx<List<Map<String, dynamic>>> foundPlayers =
      Rx<List<Map<String, dynamic>>>([]);
  RxString? keyword = ''.obs;
  //RxString? price = ''.obs;
  RxString? duration = ''.obs;
  var typeOfPuja = 'Puja for health'.obs;
  void change(typeChange) => typeOfPuja.value = typeChange;
  final Rx<List<Map<String, dynamic>>> benefit =
      Rx<List<Map<String, dynamic>>>([{
    'type':'hapiness',
    'value' :false,
  },{
    'type':'wealth',
    'value' :false,
  },
  {
    'type':'prosperity',
    'value':false,
  }
  ]);
 final Rx<List<Map<String, dynamic>>> god =
      Rx<List<Map<String, dynamic>>>([{
    'type':'vishnu',
    'value' :false,
  },{
    'type':'shiva',
    'value' :false,
  },
  {
    'type':'durga',
    'value' :false,
  },
  {
    'type':'kali',
    'value' :false,
  },
  {
    'type':'laxmi',
    'value' :false,
  },
  {
    'type':'ganesh',
    'value' :false,
  },
  {
    'type':'saraswati',
    'value' :false,
  },  
  ]);
 
  @override
  void onInit() {
    super.onInit();
    samagriFetch();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> samagriFetch() async {
    await FirebaseFirestore.instance
        .collection("assets_folder/puja_items_folder/folder")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allSamagris.add({
          "id": element.id,
          "name": element['puja_item_name'][0],
          "selected": false,
          "quantity": 'quantity',
          "type" : "deliver"
        });
      });
    }).whenComplete(() {
      foundPlayers.value = allSamagris;
    });
  }

  fetchUpdateSamagri(String puja) {
    FirebaseFirestore.instance
        .doc(
            'assets_folder/puja_ceremony_folder/folder/$puja/puja_item_folder/Bihar')
        .get()
        .then((value) {            
      foundPlayers.update((val) {
         List<dynamic> updatedSamagri = value.data()!['items'];       
        updatedSamagri.forEach((element) { 
         for (var selement in val!) { 
           if(selement['id']==element['id']){
             selement['quantity'] = element['quantity'];
             selement['selected'] = true;
           }
         }         
        });           
      });
     });
  }

  fetchGodBenefit(String puja) {
    FirebaseFirestore.instance
        .doc(
            'assets_folder/puja_ceremony_folder/folder/$puja')
        .get()
        .then((value) {            
      god.update((val) {
         List<dynamic> updatedSamagri = value.data()!['puja_ceremony_god_filter'];       
        updatedSamagri.forEach((element) { 
         for (var selement in val!) { 
           if(updatedSamagri.contains(selement['type'])){
             selement['value'] =true;            
           }
         }         
        });           
      });
     });

      FirebaseFirestore.instance
        .doc(
            'assets_folder/puja_ceremony_folder/folder/$puja')
        .get()
        .then((value) {            
      benefit.update((val) {
         List<dynamic> updatedSamagri = value.data()!['puja_ceremony_promise'];       
        updatedSamagri.forEach((element) { 
         for (var selement in val!) { 
           if(updatedSamagri.contains(selement['type'])){
             selement['value'] =true;            
           }
         }         
        });           
      });
     });
  }

  Future<void> updatesamagriFetch(String id) async {
    await FirebaseFirestore.instance
        .collection("assets_folder/puja_items_folder/folder")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        allSamagris.add({
          "id": element.id,
          "name": element['puja_item_name'][0],
          "selected": false,
          "quantity": 'quantity'
        });
      });
    }).whenComplete(() {
      foundPlayers.value = allSamagris;
    });
  }

  updateList() {
    foundPlayers.update((val) {
      val![1][''] = false;
    });
  }

  @override
  void onClose() {}
  void filterPlayer(String playerName) {
    List<Map<String, dynamic>> results = [];
    if (playerName.isEmpty) {
      results = allSamagris;
    } else {
      results = allSamagris
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    foundPlayers.value = results;
  }
}
