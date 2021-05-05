import 'package:blocauth/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  static Route route() {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, _, __) => BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginScreen(),
            ),
        settings: RouteSettings(name: routeName));
  }

  final _formkey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            // title: Text("<", style: TextStyle(color: Colors.black)),
          ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width > 600
                  ? 500
                  : MediaQuery.of(context).size.width,
              child: Form(
                key: _formkey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    state.status == LoginStatus.error
                        ? Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Container(
                              // color: Colors.red,
                              decoration: ShapeDecoration(
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        4.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      side: BorderSide(
                                          color: Colors.black, width: 2))),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(state.error.msg),
                              )),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        key: ValueKey("email"),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return "Email is not valid.";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.7),
                            ),
                            contentPadding: EdgeInsets.all(16),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(LineIcons.userAlt),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        key: ValueKey("password"),
                        validator: (value) {
                          if (value.isEmpty || value.length <= 6) {
                            return "Please Enter valid password.";
                          }
                          return null;
                        },
                        controller: pass,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.7),
                            ),
                            contentPadding: EdgeInsets.all(16),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(LineIcons.lock),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: RaisedButton(
                        padding: MediaQuery.of(context).size.width > 600
                            ? EdgeInsets.all(25)
                            : EdgeInsets.all(16),
                        color: Colors.black,
                        onPressed: state.status == LoginStatus.loading
                            ? null
                            : () async {
                                final isvalid =
                                    _formkey.currentState.validate();
                                FocusScope.of(context).unfocus();
                                if (isvalid) {
                                  _formkey.currentState.save();
                                  final isNotError =
                                      await BlocProvider.of<LoginCubit>(context)
                                          .login(email.text.trim(),
                                              pass.text.trim());
                                  if (isNotError) {
                                    Navigator.of(context).pushNamed('/Home');
                                  }
                                }
                              },
                        textColor: Colors.white,
                        child: Text(
                          "Sign in >",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 16)),
                              children: [
                                TextSpan(
                                  text: "You are new? ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: "create a new",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
