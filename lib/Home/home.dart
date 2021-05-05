import 'package:blocauth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  static const String routeName = '/Home';
  static Route route() {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, _, __) => Home(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width > 600
                  ? 500
                  : MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.all(24),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        6.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      side: BorderSide(color: Colors.black, width: 2))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello You logged in successfully!",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: () async {
                        FirebaseAuth.instance.signOut();
                        SharedPreferences prefrences =
                            await SharedPreferences.getInstance();
                        prefrences.remove('isLogin');
                        Navigator.pushReplacement(context, LoginScreen.route());
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
