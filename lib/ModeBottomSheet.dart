import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModeBottomSheet extends StatefulWidget {
  @override
  State<ModeBottomSheet> createState() => _modeBottomSheetState();
}

class _modeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDark()?MyTheme.darkGrey:null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: ()=>provider.changeTheme(ThemeMode.light),
            child: provider.isDark()
                ? getUnselctedItem(AppLocalizations.of(context)!.light)
                : getSelectedItem(AppLocalizations.of(context)!.light),
          ),
          InkWell(
            onTap: ()=>provider.changeTheme(ThemeMode.dark),
            child: provider.isDark()
                ? getSelectedItem(AppLocalizations.of(context)!.dark):
                getUnselctedItem(AppLocalizations.of(context)!.dark,
          )
          )
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Icon(
            Icons.check,
            color: MyTheme.primartight,
            size: 35,
          )
        ],
      ),
    );
  }

  Widget getUnselctedItem(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
