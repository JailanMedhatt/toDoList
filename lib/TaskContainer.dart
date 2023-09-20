import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/EditTask.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/providers/AppConfigProvider.dart';

class TaskContainer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<AppConfigProvider>(context);
    return Slidable(

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.25,
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.


        // All actions are defined in the children parameter.
        children:  [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed:(context){},
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),

        ],
      ),
      child: Container( padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color:provider.isDark()?MyTheme.darkGrey:MyTheme.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        child: IntrinsicHeight(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(EditTask.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  thickness: 3,
                  color: MyTheme.primartight,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context)!.taskName,style:Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyTheme.primartight
                        ),),
                      ), Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context)!.describtion,style:Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: (){}, child: Icon(Icons.check, color: MyTheme.whiteColor,size: 40,),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.primartight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      )
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
