import 'package:blocauth/signup/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "/signup";
  static Route route() {
    return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, _, __) => BlocProvider<SignupCubit>(
              create: (context) => SignupCubit(),
              child: SignUpScreen(),
            ),
        settings: RouteSettings(name: routeName));
  }

  SignUpScreen({Key key}) : super(key: key);
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width > 600
                ? 500
                : MediaQuery.of(context).size.width,
            child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
              return Form(
                key: _formkey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    state.status == SignupStatus.error
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.error.msg),
                              )),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        controller: email,
                        key: ValueKey("email"),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return "Email is not valid.";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                        controller: pass,
                        key: ValueKey("password"),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty || value.length <= 6) {
                            return "password must be at least 7 characters long.";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        key: ValueKey("password"),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password and Confrim Password must be same";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        padding: MediaQuery.of(context).size.width > 600
                            ? EdgeInsets.all(25)
                            : EdgeInsets.all(16),
                        color: Colors.black,
                        onPressed: state.status == SignupStatus.loading
                            ? null
                            : () async {
                                final isvalid =
                                    _formkey.currentState.validate();
                                FocusScope.of(context).unfocus();
                                if (isvalid) {
                                  _formkey.currentState.save();
                                  final isNotError =
                                      await BlocProvider.of<SignupCubit>(
                                              context)
                                          .submit(email.text, pass.text);
                                  if (isNotError) {
                                    Navigator.of(context).pushNamed('/Home');
                                  }
                                }
                              },
                        textColor: Colors.white,
                        child: Text(
                          "Sign Up >",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
