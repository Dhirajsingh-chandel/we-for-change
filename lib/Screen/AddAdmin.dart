import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/Dashboard.dart';
import 'package:we_for_change/Screen/Login_page.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  var _value;
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Add Admin",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
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
                          DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButton(
                                  value: _value,
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.deepPurple,
                                  ),
                                  hint: Text(
                                    "Select Department",
                                  ),
                                  iconSize: 24,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Drainage"),
                                      value: "drainage",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Roads"),
                                      value: "road",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Waste Management"),
                                      value: "waste_management",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Environment Related"),
                                      value: "environment",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Other"),
                                      value: "other",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  }),
                            ),
                          ),
                          SizedBox(height: 30),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () async {
                              String role = "admin";
                              String token =
                                  await FirebaseMessaging.instance.getToken();
                              user
                                  .addAdmin(
                                      _emailTextFieldController.text,
                                      _emailTextFieldController.text,
                                      _passwordTextFieldController.text,
                                      _nameTextFieldController.text,
                                      _addressTextFieldController.text,
                                      _mobileTextFieldController.text,
                                      role,
                                      _value)
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
                                        builder: (context) => Dashboard()),
                                  );
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
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            shape: StadiumBorder(),
                          )
                        ],
                      ),
                    ),
                  ),
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
