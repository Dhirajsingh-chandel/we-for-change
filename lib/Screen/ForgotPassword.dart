import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:core';

import 'Login_page.dart';
import 'SendOtoScreen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double height = mediaQueryData.size.height;
    double width = mediaQueryData.size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              height: height,
              width: width,
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Column(children: [
                            Text(
                              "Forgot your password?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sourceSansPro(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                          //    ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(children: [
                            Text(
                              "Enter your registered email below to receive a new password.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),

                          SizedBox(
                            height: 40,
                          ),

                          Row(children: [
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0)),
                            Text(
                              "Please enter your email",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 15,
                          ),

                          Container(
//                       height: MediaQuery
//                .of(context)
//                .size
//                .height / 1.2,
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Email';
                                }
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);
                                if (!emailValid) {
                                  return 'Email Not Valid';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                hintText: "example@gmail.com",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) => _email = value,
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            width: 100.0,
                            height: 40.0,
//                    decoration: new BoxDecoration(
//                      color: Color(0xff1B44B0)),

                            child: ElevatedButton(
                                child: Text(
                                  'Send',
                                  style: GoogleFonts.ptSans(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff0C65CF))),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotConformPage()),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 200),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Back to Login",
                          style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
