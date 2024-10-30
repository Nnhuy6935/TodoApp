import 'package:flutter/material.dart';

class Managesearchbox extends ChangeNotifier{
  String keyword = "";
  bool isShowSearchResult = false;

  void turnOnModeSearch(String keyword){
    this.keyword = keyword;
    this.isShowSearchResult = true;
    notifyListeners();
  }
  void turnOffModeSearch(){
    this.keyword = "";
    this.isShowSearchResult = false;
    notifyListeners();

  }


}