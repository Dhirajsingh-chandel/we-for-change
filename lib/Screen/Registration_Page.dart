import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/Dashboard.dart';
import 'package:we_for_change/Screen/Login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameTextFieldController = TextEditingController();
  final _emailTextFieldController = TextEditingController();
  final _mobileTextFieldController = TextEditingController();
  final _addressTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _nameFoucusNode = FocusNode();
  FocusNode _mobileFocusNode = FocusNode();
  FocusNode _addressFocusNode = FocusNode();

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
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 150, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 35),
                          Text(
                            "Registration",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            focusNode: _nameFoucusNode,
                            keyboardType: TextInputType.emailAddress,
                            controller: _nameTextFieldController,
                            decoration: new InputDecoration(
                              hintText: "Name",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              prefixIcon: Icon(
                                Icons.drive_file_rename_outline,
                                color: Colors.black,
                              ),
                            ),
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _nameFoucusNode, _mobileFocusNode);
                            },
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            focusNode: _mobileFocusNode,
                            keyboardType: TextInputType.number,
                            controller: _mobileTextFieldController,
                            decoration: new InputDecoration(
                              hintText: "Mobile",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              prefixIcon: Icon(
                                Icons.mobile_screen_share_outlined,
                                color: Colors.black,
                              ),
                            ),
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _mobileFocusNode, _addressFocusNode);
                            },
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            focusNode: _addressFocusNode,
                            keyboardType: TextInputType.text,
                            controller: _addressTextFieldController,
                            decoration: new InputDecoration(
                              hintText: "Address",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              prefixIcon: Icon(
                                Icons.location_history,
                                color: Colors.black,
                              ),
                            ),
                            onFieldSubmitted: (_) {
                              fieldFocusChange(
                                  context, _addressFocusNode, _emailFocusNode);
                            },
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.text,
                            controller: _emailTextFieldController,
                            decoration: new InputDecoration(
                              hintText: "Email",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
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
                              String role = "User";
                              String token =
                                  await FirebaseMessaging.instance.getToken();
                              user
                                  .registration(
                                      _emailTextFieldController.text,
                                      _emailTextFieldController.text,
                                      _passwordTextFieldController.text,
                                      _nameTextFieldController.text,
                                      _addressTextFieldController.text,
                                      _mobileTextFieldController.text,
                                      role,
                                      token)
                                  .then((response) {
                                if (response['status']) {
                                  Fluttertoast.showToast(
                                      msg: response['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.green);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: response['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.red);
                                }
                              });
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Already have an Account? ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text: 'Login',
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
                                                  LoginPage()),
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
                        padding: const EdgeInsets.only(top: 80),
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
