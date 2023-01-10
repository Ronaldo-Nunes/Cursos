import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imc_flutter_app/pages/home_page.dart';

class ImcApp extends StatelessWidget {
  const ImcApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          textTheme: GoogleFonts.robotoTextTheme(const TextTheme(
              bodyText2: TextStyle(fontSize: 16, color: Colors.black)))),
      home: const HomePage(),
    );
  }
}
