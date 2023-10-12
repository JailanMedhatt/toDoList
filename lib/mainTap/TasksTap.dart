import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/models/Task.dart';

import 'package:todo/mainTap/TaskContainer.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/providers/AuthProvider.dart';



class TaskTap extends StatefulWidget {

  const TaskTap({super.key});

  @override
  State<TaskTap> createState() => _TaskTapState();
}

class _TaskTapState extends State<TaskTap> {
  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<AuthProvider>(context);

    var provider= Provider.of<AppConfigProvider>(context);
    if(provider.tasks.isEmpty){
      provider.getTasksFromFireBase(authprovider.user?.id??"");
    }


    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: provider.selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => {provider.changeSelectedDate(date, authprovider.user?.id??"")},
            leftMargin: 20,
            monthColor: Color(0xff363636),
            dayColor: Color(0xff363636),
            activeDayColor: MyTheme.whiteColor,
            activeBackgroundDayColor: MyTheme.primartight,
            dotsColor: MyTheme.whiteColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(child: ListView.builder(itemBuilder: (context,index)=> TaskContainer(task: provider.tasks[index],),itemCount: provider.tasks.length,),
          )
        ],
      ),
    );
  }
}
