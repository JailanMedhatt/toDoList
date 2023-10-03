import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/settings/LangwageBottomSheet.dart';
import 'package:todo/settings/ModeBottomSheet.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/providers/AppConfigProvider.dart';

class SettingTap extends StatefulWidget {
  const SettingTap({super.key});

  @override
  State<SettingTap> createState() => _SettingTapState();
}

class _SettingTapState extends State<SettingTap> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(AppLocalizations.of(context)!.language, style: Theme.of(context).textTheme.titleSmall,),

        ),
        InkWell(
          onTap: ()=>showLanguageModalsheet(),
          child: Container(
            decoration: BoxDecoration(
              color:provider.isDark()?MyTheme.darkGrey: MyTheme.whiteColor,
              border: Border.all(color: MyTheme.primartight)
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.language=="en"?
                    AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic,style:Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,color:provider.isDark()?  MyTheme.primartight:null
                )
                ),
                Icon(Icons.arrow_drop_down, color: MyTheme.primartight,size: 40,)
              ],
            ),
          ),
        ),Padding(
          padding: const EdgeInsets.all(15),
          child: Text(AppLocalizations.of(context)!.mode, style: Theme.of(context).textTheme.titleSmall,),

        ),
        InkWell(
          onTap: ()=>showModeModalsheet(),
          child: Container(
            decoration: BoxDecoration(
                color:provider.isDark()?MyTheme.darkGrey: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primartight)
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.isDark()?
                AppLocalizations.of(context)!.dark:AppLocalizations.of(context)!.light,style:Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,color:provider.isDark()?  MyTheme.primartight:null
                )
                ),
                Icon(Icons.arrow_drop_down, color: MyTheme.primartight,size: 40,)
              ],
            ),
          ),
        ),
      ],
    );
  }

  showLanguageModalsheet() {
    showModalBottomSheet(context: context, builder:(context)=>languageBottomSheet());

  }

  showModeModalsheet() {
    showModalBottomSheet(context: context, builder:(context)=>ModeBottomSheet());

  }
}
