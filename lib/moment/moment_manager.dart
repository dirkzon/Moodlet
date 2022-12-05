import 'package:flutter/material.dart';

class MomentManager with ChangeNotifier {
  late DateTime startDate;
  late DateTime endDate;
  late String name;
  late String location;

  setStartDate(DateTime value) {
    startDate = value;
    notifyListeners();
  }

  setEndDate(DateTime value) {
    endDate = value;
    notifyListeners();
  }

  setName(String value) {
    name = value;
    notifyListeners();
  }

  setLocation(String value) {
    location = value;
    notifyListeners();
  }
}
