import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo/MyTheme.dart';

import 'package:todo/TaskContainer.dart';



class TaskTap extends StatelessWidget {
  const TaskTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Color(0xff363636),
            dayColor: Color(0xff363636),
            activeDayColor: MyTheme.whiteColor,
            activeBackgroundDayColor: MyTheme.primartight,
            dotsColor: MyTheme.whiteColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(child: ListView.builder(itemBuilder: (context,index)=> TaskContainer(),itemCount: 30,),
          )
        ],
      ),
    );
  }
}
