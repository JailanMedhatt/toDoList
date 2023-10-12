

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/Login.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/Register.dart';
import 'package:todo/mainTap/EditTask.dart';
import 'package:todo/providers/AppConfigProvider.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/AuthProvider.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  // The default value is 40 MB. The threshold must be set to at least 1 MB,
// and can be set to Settings.CACHE_SIZE_UNLIMITED to disable garbage collection.
//  await FirebaseFirestore.instance.disableNetwork();
//   FirebaseFirestore.instance.settings =
//       Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConfigProvider()),
       ChangeNotifierProvider(create: (_) => AuthProvider()),

      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //initSharedPerfernce();
     provider=Provider.of<AppConfigProvider>(context);
     initSharedPrefernces();
    return MaterialApp(
      initialRoute: Login.routeName,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        EditTask.routeName:(context)=>EditTask(),
        Register.routeName:(context)=>Register(),
        Login.routeName:(context)=>Login()
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
  Future<void> initSharedPrefernces() async{
    final prefs = await SharedPreferences.getInstance();
   var lang = prefs.getString("language");
   if(lang!=null){
     provider.changeLanguage(lang);
   }
   bool? isDark= prefs.getBool("isDarkThemeMode");
   if(isDark== true){
     provider.changeTheme(ThemeMode.dark);
   }
   else if(isDark== false){
     provider.changeTheme(ThemeMode.light);
   }
  }


}






