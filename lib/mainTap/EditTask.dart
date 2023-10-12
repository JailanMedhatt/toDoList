import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/models/Task.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/providers/AuthProvider.dart';

class EditTask extends StatefulWidget {
  static const routeName = "editTsk";
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final titleController= TextEditingController();
  final descController= TextEditingController();

  late DateTime selectedDatee=DateTime.now();
  String task='';
  String desc='';



  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<AuthProvider>(context);
    Task passedTask= ModalRoute.of(context)?.settings.arguments as Task;
    titleController.text=passedTask.title??"";
    descController.text=passedTask.desc??"";
    selectedDatee=passedTask.dateTime!;
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.toDoList,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: provider.isDark() ? MyTheme.darkGrey : MyTheme.whiteColor,
          borderRadius: BorderRadius.circular(20)
        ),

        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08,
        vertical: MediaQuery.of(context).size.height*0.05),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.008,
            vertical: MediaQuery.of(context).size.height*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.editTask,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: titleController,
                onChanged: (text){
                   task=text;
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.taskName,
                    hintStyle: TextStyle(
                        color: provider.isDark()
                            ? Color.fromRGBO(205, 202, 202, 0.91)
                            : null,

                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: descController,
                onChanged: (text){

                   desc=text;
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.describtion,
                    hintStyle: TextStyle(
                        color: provider.isDark()
                            ? Color.fromRGBO(205, 202, 202, 0.91)
                            : null)),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.selectDate,
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            InkWell(
                onTap: () {
                  showCalendar(passedTask);

                },
                child: Text(
                  "${selectedDatee.day}/${selectedDatee.month}/${selectedDatee.year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: provider.isDark()
                          ? Color.fromRGBO(205, 202, 202, 0.91)
                          : null),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: ElevatedButton(
                  onPressed: () {
                    if(task!=""){
                      FireBaseMethods.getTasksCollection(authprovider.user?.id??"").doc(passedTask.id).update({"title":task}).timeout(Duration(milliseconds: 500));
                    }
                    if(desc!=""){
                      FireBaseMethods.getTasksCollection(authprovider.user?.id??"").doc(passedTask.id).update({"desc":desc}).timeout(Duration(milliseconds: 500));
                    }
                    if(selectedDatee?.millisecondsSinceEpoch!=passedTask.dateTime){
                      FireBaseMethods.getTasksCollection(authprovider.user?.id??"").doc(passedTask.id).update({"dateTime":selectedDatee?.millisecondsSinceEpoch}).timeout(Duration(milliseconds: 500));
                    }
                    provider.getTasksFromFireBase(authprovider.user?.id??"");
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.saveChanges,
                    style: TextStyle(fontSize: 20),
                  ),style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015)
              ),),
            )
          ],
        ),
      ),
    );
  }

  void showCalendar(Task t) async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDatee,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedDate != null) {
      selectedDatee = selectedDate;
      t.dateTime=selectedDate;


    }
    setState(() {});
  }
}
