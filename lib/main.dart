import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rootally_ai/view/home_screen/home_page.dart';
import 'package:rootally_ai/view/sign_in_screen/sign_in_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: isLoggedIn ? const HomePage() : const SignInUI(),
    ),
  );
}
