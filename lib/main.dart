import 'package:flutter/material.dart';
import 'package:login_signup_ui/app_screen/login_page.dart';
import 'package:login_signup_ui/app_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green, accentColor: Colors.green[800]),
      home: SplashScreen(),
      
routes: <String, WidgetBuilder> {
      '/loginPage': (BuildContext context) => LoginPage(),
    },

    );
  }
}
