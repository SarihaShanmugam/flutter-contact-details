import 'package:contact_details/contact_form1_screen.dart';
import 'package:contact_details/time_picker.dart';
import 'package:flutter/material.dart';


import 'contact_form_screen.dart';
import 'database_helper.dart';
import 'optimized_contact_details.dart';

// DatabaseHelper dbHelper = new dbHelper();
final dbHelper = DatabaseHelper();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.initialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OptimizedContactDetailsFormScreen(),
    );
  }
}
