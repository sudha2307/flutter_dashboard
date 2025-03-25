import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dashboard',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => HubCenter(student: {},),
      },
    );
  }
}
