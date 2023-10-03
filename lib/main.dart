

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/mainTap/EditTask.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:provider/provider.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  // The default value is 40 MB. The threshold must be set to at least 1 MB,
// and can be set to Settings.CACHE_SIZE_UNLIMITED to disable garbage collection.

  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp( ChangeNotifierProvider(create:(context)=>AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //initSharedPerfernce();
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






