import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier {
  int mid = 0;
  String url = "127.0.0.1";

  void setMid(int i) {
    mid = i;
    notifyListeners();
  }

  int getMid() {
    return mid;
  }

  String getUrl() {
    return url;
  }
}
