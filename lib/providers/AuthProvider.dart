import 'package:flutter/material.dart';
import 'package:todo/models/User.dart';

class AuthProvider extends ChangeNotifier{
MyUser? user;
void updateUser(MyUser? userr){
  user =userr;
  notifyListeners();
}

}