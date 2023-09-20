import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String language="en";
  ThemeMode themeMode= ThemeMode.dark;
  void changeLanguage(String newLan){
    if(newLan==language){
      return;
    }
    language= newLan;
    notifyListeners();
  }
  void changeTheme(ThemeMode newTheme){
    if(newTheme==themeMode){
      return;
    }
    themeMode=newTheme;
    notifyListeners();
  }
  bool isDark(){
    return themeMode==ThemeMode.dark;
  }
}