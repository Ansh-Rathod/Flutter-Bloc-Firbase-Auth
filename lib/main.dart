import 'package:blocauth/Home/home.dart';
import 'package:blocauth/login/login_screen.dart';
import 'package:blocauth/router/custom_router.dart';
import 'package:blocauth/signup/cubit/signup_cubit.dart';
import 'package:blocauth/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefrences = await SharedPreferences.getInstance();
  bool isLoggedin = prefrences.getBool('isLogin');
  runApp(MyApp(isLoggedin));
}

class MyApp extends StatelessWidget {
  final bool isLoggedin;

  MyApp(this.isLoggedin);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme
          ),
          primarySwatch: Colors.blue,
        ),
        
        onGenerateRoute: CustomRouter.onGenrateRoute,
        initialRoute: isLoggedin == null
            ? LoginScreen.routeName
            : Home.routeName);
  }
}
