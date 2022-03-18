import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Purohit {
  final AsyncSnapshot< DocumentSnapshot> snapshot;

  Purohit(this.snapshot);

  dynamic get name => snapshot.data!.get("pandit_name");

  dynamic get bio => snapshot.data!.get("pandit_bio");

  dynamic get age => snapshot.data!.get("pandit_age");

  dynamic get mobile => snapshot.data!.get("pandit_mobile_number");

  dynamic get city => snapshot.data!.get("pandit_city");

  dynamic get state => snapshot.data!.get("pandit_state");

  dynamic get expertise => snapshot.data!.get("pandit_expertise");

  dynamic get experience => snapshot.data!.get("pandit_experience");

  dynamic get qualification => snapshot.data!.get("pandit_qualification");

  bool get verification => snapshot.data!.get("pandit_verification_status");

  dynamic get swastik => snapshot.data!.get("pandit_swastik");

  dynamic get profileUrl => snapshot.data!.get("pandit_display_profile") ?? "https://lanecdr.org/wp-content/uploads/2019/08/placeholder.png";

  dynamic get coverUrl => snapshot.data!.get("pandit_cover_profile");

  dynamic get pictures => snapshot.data!.get("pandit_pictures") ?? [null, null, null, null];

  dynamic get type => snapshot.data!.get("pandit_type");

  dynamic get joining => snapshot.data!.get("pandit_joining_date");

  dynamic get update => snapshot.data!.get("pandit_profile_update_date");

  dynamic get language => snapshot.data!.get("pandit_language");

  dynamic get appLanguage => snapshot.data!.get("pandit_app_language_code");

  dynamic get email => snapshot.data!.get("pandit_email");

  dynamic get id => snapshot.data!.get("pandit_id");

  dynamic get uid => snapshot.data!.id;
}
