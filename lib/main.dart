import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmamenu/Authentication/authMonitor.dart';
import 'package:sigmamenu/GeneralFunction/shared_preferences.dart';
import 'package:sigmamenu/language/logic/ProjectLanguage.dart';
import 'package:sigmamenu/provider/ProjectLanguageProvider.dart';
import 'package:sigmamenu/provider/darkLightMode.dart';
import 'package:sigmamenu/provider/userStateProvider.dart';
import 'package:sigmamenu/screens/adminPanel.dart';
import 'package:sigmamenu/screens/home/components/shimmer.dart';
import 'package:sigmamenu/screens/staggeredGridView.dart';
import 'package:sigmamenu/screens/widgets/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    
    super.initState();
    getLocale();
  }

  ///This gets the last stored language setting for the user, and loads it up the first time the app starts.~Huthaifa
  getLocale() async {
    String language = await StorageProvider().getLanguage();

    setState(() {
      ProjectLanguage.locale =
          language == "en" ? Locale("en", "US") : Locale("ar", "JO");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserState>(
            create: (_) => UserState(),
          ),

          ChangeNotifierProvider<ProjectLanguageChangeNotifier>(
            create: (_) => ProjectLanguageChangeNotifier(),
          ),
          // ChangeNotifierProvider<CategoryProvider>(
          //     create: (_) => CategoryProvider()),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(),),
        ],
        builder: (context, child) {
          return MaterialApp(
          // Provider.of<ProjectLanguageChangeNotifier>(context, listen: true)
          //     .setlocale(ProjectLanguage.locale);
          // return MultiProvider(
          //     providers: [
          //       // ChangeNotifierProvider<UserState>(
          //       //   create: (_) => UserState(),
          //       // ),
          //       ChangeNotifierProvider<ProjectLanguageChangeNotifier>(
          //         create: (_) => ProjectLanguageChangeNotifier(),
          //       ),],
          // return MaterialApp(
            // key: GlobalKey<FormState>(),
            locale: Provider.of<ProjectLanguageChangeNotifier>(context, listen: true)
                .locale,
            // localizationsDelegates: [
            //   ProjectLanguage.delegate,
            // ],
            debugShowCheckedModeBanner: false,
            title: 'Sigma Menu',
                    // theme: child!.getTheme(),
            theme: ThemeData(
              // primaryColor: Colors.brown,
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.brown,
              ).copyWith(),

              textTheme: Theme.of(context).textTheme.apply(
                  // displayColor: Colors.brown,
                  // decorationColor: Colors.brown,
                  // bodyColor: Colors.brown
                  ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              // '/': (context) => const FirstScreen(),
              // When navigating to the "/second" route, build the SecondScreen widget.
              '/admin': (context) => AdminPanel(),
              '/dashboard': (context) => StaggerdGridView(),
              '/loading':(context)=> LoadingListPage(),
              '/drawer':(context)=>Drawerr()
            },
            home: AuthMonitor(),
            // ),
          );
        });
  }
}
