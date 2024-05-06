import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier{
  int mid=0;

  void setMid(int i){
    mid=i;
    notifyListeners();
  }

  int getMid(){
    return mid;
  }
}