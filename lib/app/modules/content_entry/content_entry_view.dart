import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management/main.dart';
import 'package:management/resources/app_strings.dart';
import '../../../../resources/app_components/function_cards.dart';
import 'package:get/get.dart';

class ContentEntryView extends StatelessWidget {
  final String id;
  ContentEntryView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Wrap(
              children: [
//TODO: role display options
              ],
            )));
  }
}

Map contentEntryFunctionCards = {
  'Puja': FunctionCards(
    iconData: CupertinoIcons.bolt_horizontal_circle,
    text: 'Puja',
    ontap: () async {
      Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/update_puja/up');
    },
  ),
  'Samagri': FunctionCards(
    iconData: CupertinoIcons.archivebox,
    text: 'Samagri',
    ontap: () {
      Get.toNamed('/home/${AppStrings.CONTENT_ENTRY}/samagri');
    },
  ),
  'Calender': const FunctionCards(
    iconData: CupertinoIcons.calendar,
    text: 'Calender',
  ),
  'Muhurat': const FunctionCards(
    iconData: CupertinoIcons.calendar_today,
    text: 'Muhurat',
  ),
};
