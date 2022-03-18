import 'package:management/resources/app_strings.dart';
import 'package:management/roles/role.dart';

class SuperAdmin extends Role {
  @override
  SuperAdmin get role => this;

  SuperAdmin()
      : super(availableContentEntryFunctionCards: [
          'Puja',
          'Samagri',
          'Calender',
          'Muhurat',
          'Add Upcoming',
          'Change Banner',
          'Add Detail'
            ], availableContentEntryTabs: [
          'up',
          'rp',
          'an'
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
