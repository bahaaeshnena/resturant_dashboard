import 'package:flutter/material.dart';

class TableStatusNotifier extends ChangeNotifier {
  String _status;

  TableStatusNotifier(this._status);

  String get status => _status;

  void setStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }
}
