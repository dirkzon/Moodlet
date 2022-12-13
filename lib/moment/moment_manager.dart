import 'package:flutter/material.dart';
import 'package:bletest/moment/moment_categories.dart';
import 'momentEnums.dart';

class MomentManager with ChangeNotifier {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(hours: 1));
  String name = "";
  String location = "";
  List<MomentCategory> categories = [];
  Pleasure pleasure = Pleasure.neutral;
  Arousal arousal = Arousal.neutral;
  Dominance dominance = Dominance.neutral;
  String additionalNotes = "";

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
    startDate = DateTime.now();
    endDate = DateTime.now().add(const Duration(hours: 1));
    name = "";
    location = "";
    pleasure = Pleasure.neutral;
    arousal = Arousal.neutral;
    dominance = Dominance.neutral;
    additionalNotes = "";
  }
}
