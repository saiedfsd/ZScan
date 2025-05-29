import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZScanner',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
