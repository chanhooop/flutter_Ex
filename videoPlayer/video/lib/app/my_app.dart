import 'package:flutter/material.dart';
import 'package:video/views/main_view_page.dart';
import 'package:video/views/pre_start.dart';
import 'package:video/views/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: PreStart.routeName,
      routes: {
        MainViewPage.routeName: (_) => const MainViewPage(),
        SplashPage.routeName: (_) => const SplashPage(),
        PreStart.routeName: (_) => const PreStart(),
      },
    );
  }
}
