import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class languageBottomSheet extends StatefulWidget {
  @override
  State<languageBottomSheet> createState() => _languageBottomSheetState();
}

class _languageBottomSheetState extends State<languageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDark()?MyTheme.darkGrey:null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: ()=>provider.changeLanguage("en"),
            child: provider.language == "en"
                ? getSelectedItem(AppLocalizations.of(context)!.english)
                : getUnselctedItem(AppLocalizations.of(context)!.english),
          ),
          InkWell(
            onTap: ()=>provider.changeLanguage("ar"),
            child: provider.language == "en"
                ? getUnselctedItem(AppLocalizations.of(context)!.arabic):
                getSelectedItem(AppLocalizations.of(context)!.arabic),
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
