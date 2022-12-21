import 'package:bletest/comms/hive/models/hiveMoment.dart';
import 'package:flutter/material.dart';
import 'package:bletest/moment/moment_categories.dart';
import 'momentEnums.dart';

class MomentManager with ChangeNotifier {
  String id = "";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(hours: 1));
  String name = "";
  String location = "";
  List<MomentCategory> categories = [];
  Pleasure pleasure = Pleasure.neutral;
  Arousal arousal = Arousal.neutral;
  Dominance dominance = Dominance.neutral;
  String additionalNotes = "";

  setId(String id) {
    id = id;
    notifyListeners();
  }

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

  categoryNames() {
    List<String> categoryNames = [];
    categories.forEach((e) {
      categoryNames.add(e.name);
    });
    return categoryNames;
  }

  retrieveCategories(List<String> categoryNames) {
    List<MomentCategory> categories = [];

    categoryNames.forEach((e) {
      momentCategories.forEach((element) {
        if (element.name == e) {
          categories.add(element);
        }
      });
    });

    return categories;
  }

  setCategories(List<MomentCategory> value) {
    categories = value;
    notifyListeners();
  }

  setPleasure(Pleasure value) {
    pleasure = value;
    notifyListeners();
  }

  setArousal(Arousal value) {
    arousal = value;
    notifyListeners();
  }

  setDominance(Dominance value) {
    dominance = value;
    notifyListeners();
  }

  setAdditionalNotes(String value) {
    additionalNotes = value;
    notifyListeners();
  }

  clearMoment() {
    id = "";
    startDate = DateTime.now();
    endDate = DateTime.now().add(const Duration(hours: 1));
    name = "";
    location = "";
    categories.clear();
    pleasure = Pleasure.neutral;
    arousal = Arousal.neutral;
    dominance = Dominance.neutral;
    additionalNotes = "";
  }

  retrieveMoment(HiveMoment moment) {
    id = moment.key;
    startDate = moment.startDate;
    endDate = moment.endDate;
    name = moment.name;
    location = moment.location;
    categories = retrieveCategories(moment.categories);
    pleasure = Pleasure.values[moment.pleasure];
    arousal = Arousal.values[moment.arousal];
    dominance = Dominance.values[moment.dominance];
    additionalNotes = moment.additionalNotes;
  }

  bool isValid() {
    return name != "" && startDate.isBefore(endDate);
  }
}
