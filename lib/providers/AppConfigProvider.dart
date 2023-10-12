

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/Task.dart';

class AppConfigProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  String language = "en";
  ThemeMode themeMode = ThemeMode.light;
  void changeLanguage(String newLan) async {
    if (newLan == language) {
      return;
    }
    language = newLan;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async{
    if (newTheme == themeMode) {
      return;
    }
    themeMode = newTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkThemeMode", isDark());
    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  void getTasksFromFireBase(String id) async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseMethods.getTasksCollection(id).get();
    tasks = querySnapshot.docs.map((doc) => doc.data()).toList();
    tasks = tasks.where((task) {
      if (task.dateTime!.day == selectedDate.day &&
          task.dateTime!.month == selectedDate.month&&
          task.dateTime!.year==selectedDate.year) {
        return true;
      }
      return false;
    }).toList();
    tasks.sort(
        (Task task1, Task task2){
          return task1.dateTime!.compareTo(task2.dateTime!);
        }
    );
    notifyListeners();
  }

  void changeSelectedDate(DateTime newDate, String id) {
    selectedDate = newDate;
    getTasksFromFireBase(id);
  }
}
