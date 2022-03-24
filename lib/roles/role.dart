import 'package:flutter/cupertino.dart';
import 'package:management/app/modules/content_entry/content_entry_view.dart';
import 'package:management/app/modules/content_entry/puja_section/views/puja_tab.dart';
import 'package:management/app/modules/home/view/home_view.dart';
import 'package:management/roles/super_admin.dart';

abstract class Role {
  List availablePanditActions;

  Role? get role;
  List availableContentEntryFunctionCards;
  List availableContentEntryTabs;
  List availableFeatures;

  Role(
      {required this.availableContentEntryFunctionCards,
      required this.availableContentEntryTabs,
      required this.availablePanditActions,
      required this.availableFeatures});

  canUpdate() {
    return role is SuperAdmin;
  }

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

  displayPanditActions(currentPage) {
    // Map all = panditActions(currentPage);
    List display = [];

    // initializeFields(availablePanditActions, display, all);
    return display;
  }

  displayFeatures(context, tab) {
    Map all = allFeatures(context, tab);
    List display = [];

    initializeFields(availableFeatures, display, all);
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
