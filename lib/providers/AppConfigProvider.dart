import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/Task.dart';

class AppConfigProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  String language = "en";
  ThemeMode themeMode = ThemeMode.light;
  void changeLanguage(String newLan) {
    if (newLan == language) {
      return;
    }
    language = newLan;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (newTheme == themeMode) {
      return;
    }
    themeMode = newTheme;
    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  void getTasksFromFireBase() async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseMethods.getTasksCollection().get();
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

  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getTasksFromFireBase();
  }
}
