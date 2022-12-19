import 'package:bletest/comms/hive/adaptors/hiveProfileRepository.dart';
import 'package:flutter/cupertino.dart';

class ProfileManager extends ChangeNotifier {
  DateTime birthDay = DateTime(2000, 0, 0);
  String name = '';
  bool isBirthDay = false;

  ProfileManager(HiveProfileRepository profileRepo) {
    var profile = profileRepo.getProfile();
    if (profile != null) {
      birthDay = profile.birthDay;
      name = profile.name;
      isBirthDay = _isBirhtDay(birthDay);
    }
  }

  setBirthDay(DateTime day) {
    birthDay = day;
    isBirthDay = _isBirhtDay(day);
    notifyListeners();
  }

  setName(String newName) {
    name = newName;
    notifyListeners();
  }

  bool _isBirhtDay(DateTime birhtDay) {
    var now = DateTime.now();
    return (now.day == birthDay.day && now.month == birthDay.month);
  }
}
