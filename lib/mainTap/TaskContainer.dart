import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseMethod.dart';
import 'package:todo/models/Task.dart';
import 'package:todo/mainTap/EditTask.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:todo/providers/AuthProvider.dart';

class TaskContainer extends StatefulWidget {
  Task task;
  TaskContainer({required this.task});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<AuthProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                FireBaseMethods.deleteTaskFromFireStore(widget.task,authprovider.user?.id??"").then((value) {
                  return  provider.getTasksFromFireBase(authprovider.user?.id??"");
                },);

              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),

          decoration: BoxDecoration(
              color: provider.isDark() ? MyTheme.darkGrey : MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(20)),
          child: IntrinsicHeight(
            child: InkWell(
              onTap: () {
                 Navigator.of(context).pushNamed(EditTask.routeName, arguments: widget.task);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalDivider(
                    thickness: 3,
                    color:widget.task.isdone==false? MyTheme.primartight:MyTheme.greenColor,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.task.title ?? '',
                            style: widget.task.isdone==false? Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.primartight): Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.greenColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.task.desc ?? '',
                              style:Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: widget.task.isdone==true?MyTheme.greenColor:null
                              ))
                          ,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(widget.task.isdone==false){
                      widget.task.isdone=true;
                     FireBaseMethods.getTasksCollection(authprovider.user?.id??"").doc(widget.task.id).update({"isDone":true});}
                      else{
                        widget.task.isdone=false;
                        FireBaseMethods.getTasksCollection(authprovider.user?.id??"").doc(widget.task.id).update({"isDone":false});
                      }
                      setState(() {

                      });
                    },
                    child:widget.task.isdone==false? Icon(
                      Icons.check,
                      color: MyTheme.whiteColor,
                      size: 40,
                    ):Text("Done ! ", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25,color: MyTheme.greenColor)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:widget.task.isdone==false? MyTheme.primartight:Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  )

                ],
              ), 
            ),
          ),
        ),
      ),
    );
  }
}
