import 'package:bletest/comms/hive/models/hiveEntry.dart';
import 'package:bletest/profile/profile_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../models/hiveProfile.dart';

class HiveProfileRepository with ChangeNotifier {
  Box<HiveProfile> box = Hive.box<HiveProfile>("profile");

  saveProfile(HiveProfile profile) {
    box.put('profile', profile);
  }

  HiveProfile? getProfile() {
    return box.get('profile');
  }

  update(ProfileManager manager) {
    saveProfile(HiveProfile(birthDay: manager.birthDay, name: manager.name));
  }
}
