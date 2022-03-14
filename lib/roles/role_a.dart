import 'package:management/roles/role.dart';

class RoleA extends Role {
  @override
  RoleA get role => this;

  RoleA() : super(availableContentEntryFunctionCards: ['Puja'], availableContentEntryTabs: ['an']);
}
