import "package:flutter/material.dart";

class UserProvider extends ChangeNotifier {
  String imgStr="";
  String memberName="";
  int mid = 0;
  String url = "192.168.0.104";
  int currentPage=0;

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

  void setCurrentPage(int i) {
    currentPage = i;
    notifyListeners();
  }

  int getCurrentPage() {
    return currentPage;
  }
  void setMemberName(String i){
    this.memberName=i;
    notifyListeners();
  }

  String getMemberName(){
    return memberName;
  }
  void setImgStr(String i){
    this.imgStr=i;
    notifyListeners();
  }

  String getImgStr(){
    return imgStr;
  }
}
