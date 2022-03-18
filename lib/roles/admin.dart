import 'package:management/resources/app_strings.dart';
import 'package:management/roles/role.dart';

class Admin extends Role {
  @override
  Admin get role => this;

  Admin()
      : super(availableContentEntryFunctionCards: [
          'Puja',
          'Samagri',
          'Calender',
          'Muhurat'
        ], availableContentEntryTabs: [
          'up'
        ], availablePanditActions: [
          "Basic Details",
          "Bank Details",
          "UIDAI Details",
          "Puja Ceremony Services Details",
          "Booking Details",
        ], availableFeatures: [
          AppStrings.CONTENT_ENTRY,
          AppStrings.MANAGEMENT,
        ]);
}
