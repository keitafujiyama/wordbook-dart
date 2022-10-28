// PACKAGE
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'class.dart';
import 'provider.dart';
import 'screen.dart';



// MAIN
void main () {
  runApp (const MyApp ());

  setUrlStrategy (PathUrlStrategy ());
}

class MyApp extends StatelessWidget {

  // CONSTRUCTOR
  const MyApp ({super.key});



  // MAIN
  @override
  Widget build (BuildContext context) {
    rootBundle.loadString ('asset/open_font_license.txt').then ((String licence) => LicenseRegistry.addLicense (() => Stream <LicenseEntry>.fromIterable (<LicenseEntry> [LicenseEntryWithLineBreaks (<String> ['google_fonts'], licence)])));

    return ChangeNotifierProvider (
      create: (_) => DatabaseProvider ()..readJson (),
      child: MaterialApp (
        initialRoute: '/',
        title: 'WORDBOOK | KEITA FUJIYAMA',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/book':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => BookScreen (settings.arguments as BookClass));

            case '/home':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => const HomeScreen ());

            case '/result':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => ResultScreen (settings.arguments as TestClass));

            case '/test':
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => TestScreen (settings.arguments as TestClass));

            default:
              return PageRouteBuilder <void> (pageBuilder: (_, __, ___) => const SplashScreen ());
          }
        },
        theme: ThemeData (
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme (
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: double.minPositive,
            iconTheme: const IconThemeData (color: Colors.red),
            titleTextStyle: GoogleFonts.notoSans (
              color: Colors.red,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
