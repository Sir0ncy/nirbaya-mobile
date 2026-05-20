import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(const NirbayaApp());
}

class NirbayaApp extends StatelessWidget {
  const NirbayaApp({super.key});

  static const Color _brandBlue = Color(0xFF263B61);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirbaya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _brandBlue),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      initialRoute: AppRoutes.landing,
      routes: AppRoutes.routes,
    );
  }
}
