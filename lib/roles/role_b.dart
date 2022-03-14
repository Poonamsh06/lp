import 'package:management/roles/role.dart';

class RoleB extends Role {

  @override
  RoleB get role => this;


  RoleB() : super(availableContentEntryFunctionCards: ['Puja', 'Samagri', 'Calender', 'Muhurat'], availableContentEntryTabs: ['up','rp','an']);
}
