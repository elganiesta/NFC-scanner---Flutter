import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/splash.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(testDeviceIds: ['F88D249D3AE7F0D5C62C8C07C0F615A4']);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/': (context) => HomeScreen(),
        '/splash': (context) => SplashScreen()
      },
    );
  }
}
