

import 'package:flutter/material.dart';
import 'package:todo/EditTask.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp( ChangeNotifierProvider(create:(context)=>AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        EditTask.routeName:(context)=>EditTask()
      },
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lighTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.language),
      themeMode: provider.themeMode,
      darkTheme: MyTheme.darkTheme,


    );

  }
}






