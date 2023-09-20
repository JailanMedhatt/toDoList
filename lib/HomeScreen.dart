import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/SettingTap.dart';
import 'package:todo/TasksTap.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/toAddWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;
  List<Widget> taps=[TaskTap(),SettingTap()];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex==0?AppLocalizations.of(context)!.toDoList:AppLocalizations.of(context)!.settings,
          style:Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDark()?MyTheme.darkGrey:MyTheme.whiteColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            currentIndex: selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, size: 30), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30), label: ""),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showToAddBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:taps[selectedIndex]
    );
  }
  void showToAddBottomSheet() {
    showModalBottomSheet(context: context, builder: (context)=>ToAddWidget());
  }
}


