import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Task.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/providers/AuthProvider.dart';

class ToAddWidget extends StatefulWidget {
  @override
  State<ToAddWidget> createState() => _ToAddWidgetState();
}

class _ToAddWidgetState extends State<ToAddWidget> {
  final formKey = GlobalKey<FormState>();
  //late DateTime selectedDatee;
  String enteredTitle = "";
  String enteredDes = "";
  var provider;

 DateTime selectedDatee=DateTime.now();

  @override
  Widget build(BuildContext context) {

    var authprovider= Provider.of<AuthProvider>(context);
    provider = Provider.of<AppConfigProvider>(context);


    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: provider.isDark() ? MyTheme.darkGrey : MyTheme.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.addNewTask,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (text) => enteredTitle = text,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.enterYourTaskName,
                          hintStyle: TextStyle(
                              color: provider.isDark()
                                  ? Color.fromRGBO(205, 202, 202, 0.91)
                                  : null)),
                      validator: (text) => text == null || text.isEmpty
                          ? AppLocalizations.of(context)!.taskNameRequired
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (text) => enteredDes = text,
                      decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.enterYourTaskDesc,
                          hintStyle: TextStyle(
                              color: provider.isDark()
                                  ? Color.fromRGBO(205, 202, 202, 0.91)
                                  : null)),
                      validator: (text) => text == null || text.isEmpty
                          ? AppLocalizations.of(context)!.describtionRequired
                          : null,
                      maxLines: 4,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.selectDate,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          InkWell(
              onTap: () {
                showCalendar();
              },
              child: Text(
                "${selectedDatee?.day}/${selectedDatee?.month}/${selectedDatee?.year}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: provider.isDark()
                        ? Color.fromRGBO(205, 202, 202, 0.91)
                        : null),
              )),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: MediaQuery.of(context).size.height * 0.02),
            child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() == true) {
                    Task task = Task(
                        dateTime: selectedDatee,
                        title: enteredTitle,
                        desc: enteredDes);
                    FireBaseMethods.addTaskToFireStore(task,authprovider.user?.id??"")
                        .then((value){
                        return provider.getTasksFromFireBase(authprovider.user?.id??"");
                        });
                    Navigator.pop(context);
                    print("task added");
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }

  void showCalendar() async {

    var selectedDate = await showDatePicker(
        context: context,
        initialDate: provider.selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedDate != null) {
      selectedDatee = selectedDate;
    }

    setState(() {});
  }
}
