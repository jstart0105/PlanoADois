import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plano_a_dois/dashboard/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plano a Dois',
      theme: ThemeData(
        primaryColor: const Color(0xff4f46e5), // indigo-600
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4f46e5)),
        fontFamily: 'Inter',
      ),
      home: const DashboardScreen(),
    );
  }
}