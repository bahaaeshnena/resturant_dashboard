import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  bool _isCalendarVisible = false;

  DateTime get selectedDate => _selectedDate;
  bool get isCalendarVisible => _isCalendarVisible;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void toggleCalendarVisibility() {
    _isCalendarVisible = !_isCalendarVisible;
    notifyListeners();
  }

  // Formatting the date as 'yyyy-MM-dd' for comparison
  String getFormattedDate() {
    return '${_selectedDate.toIso8601String().split('T').first}';
  }
}
