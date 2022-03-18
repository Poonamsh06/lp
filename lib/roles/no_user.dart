import 'package:management/resources/app_strings.dart';
import 'package:management/roles/role.dart';

class NoUser extends Role {
  @override
  NoUser get role => this;

  NoUser() : super(availableContentEntryFunctionCards: [], availableContentEntryTabs: [], availablePanditActions: [], availableFeatures: []);
}
