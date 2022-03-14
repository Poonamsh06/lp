import 'package:flutter/cupertino.dart';
import 'package:management/app/modules/content_entry/content_entry_view.dart';
import 'package:management/app/modules/content_entry/puja_view/views/puja_tab.dart';

abstract class Role {
  Role? get role;
  List availableContentEntryFunctionCards;
  List availableContentEntryTabs;

  Role({required this.availableContentEntryFunctionCards, required this.availableContentEntryTabs});

  displayContentEntryFunctionCards() {
    List display = [];
    initializeFields(availableContentEntryFunctionCards, display, contentEntryFunctionCards);
    return display;
  }

  displayContentEntryTabs(tab) {
    Map all = pujaTabs(tab);
    List display = [];
    initializeFields(availableContentEntryTabs, display, all);
    return display;
  }

// Helper Functions
  initializeFields(List available, List display, Map all) {
    try {
      for (var func in available) {
        if (all[func] == null) {
          throw FlutterError("${func} is not an available action, available actions are : ${all.keys.toString()}");
        }
        display.add(all[func]);
      }
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }
}
