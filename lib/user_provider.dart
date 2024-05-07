import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier{
  int mid=0;
  String url="192.168.0.105";

  void setMid(int i){
    mid=i;
    notifyListeners();
  }

  int getMid(){
    return mid;
  }

  String getUrl(){
    return url;
  }
}