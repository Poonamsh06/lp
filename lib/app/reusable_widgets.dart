import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/main.dart';

Widget updateButton(action) {
  return superAdminActionButton(action, "Update");
}

Widget superAdminActionButton(action, title) {
  if (Get.find<AuthDataController>().role.value.canUpdate()) {
    return InkWell(
      onTap: action,
      child: redButton(title),
    );
  } else {
    return SizedBox.shrink();
  }
}

Widget redButton(String text) {
  return Container(
    margin: EdgeInsets.all(20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red, width: 2.0)),
    child: Text(text),
  );
}
