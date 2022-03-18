import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management/main.dart';
import 'package:management/resources/app_components/custom_widgets.dart';

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

