import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ForgotPassword.dart';

class ForgotConformPage extends StatefulWidget {
//  String email;
//  ForgotConformPage(this.email);


  @override
  _ForgotConformPageState createState() => _ForgotConformPageState();
}

class _ForgotConformPageState extends State<ForgotConformPage> {
//  late String email;
//  ForgotConformPage(this.email);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                IconButton(
                  iconSize: 150.0,
                  icon: Image.asset(
                    "assets/icons/ForgetPasswordConf.png",
                    alignment: Alignment.center,
                  ),
                  onPressed: () {  },
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "Temporary password sent!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(child:Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0,0.0),
                  child: Text(
//                    email,
                    "A temporary password has been sent to your registered email , You can login using this temporary password & create a new password from within the App.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                      textStyle: TextStyle(
                        height: 1.2,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.grey,
                      ),

                    ),
                  ),
                ),
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  width: 300.0,
                  height: 50.0,
//                    decoration: new BoxDecoration(
//                      color: Color(0xff1B44B0)),

                  child: ElevatedButton(
                    child: Text('Okay',
                        style: GoogleFonts.ptSans(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        )
                    ),
                    style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Color(0xff0C65CF))
                    ), onPressed: () {  },

//                    ElevatedButton.styleFrom(
//
//                        primary: Colors.white,
//                      shadowColor: Colors.white
//                    ),

                  ),
                ),

              ],
            ),
          ),
        ) );
  }
}
