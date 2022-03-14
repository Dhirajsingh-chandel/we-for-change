import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/Dashboard.dart';
import 'package:we_for_change/Screen/Registration_Page.dart';

import 'ForgotPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: HexColor("#E9EAF0"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 220, horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: _emailTextFieldController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                          onFieldSubmitted: (_) {
                            fieldFocusChange(
                                context, _emailFocusNode, _passwordFocusNode);
                          },
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: _passwordTextFieldController,
                          focusNode: _passwordFocusNode,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.black.withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          onFieldSubmitted: (_) {
                            fieldFocusChange(context, _passwordFocusNode,
                                _passwordFocusNode);
                          },
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () async {
                            String token =
                                await FirebaseMessaging.instance.getToken();
                            user
                                .authenticate(_emailTextFieldController.text,
                                    _passwordTextFieldController.text, token)
                                .then((response) {
                              if (response['status']) {
                                print(response['user']);
                                UserData user = response['user'];
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setUser(user);
                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white);
                              }
                            });
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 10),
                        Text.rich(TextSpan(
                            text: 'Forget Password',
                            style: new TextStyle(
                                color: Color(0xff0C65CF),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()),
                                );
                              })),
                        Container(
                          child: Text(
                            "Or",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "New to We for Change? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: 'Create Account',
                                  style: new TextStyle(
                                      color: Color(0xff0C65CF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationPage()),
                                      );
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 145),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 150,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
