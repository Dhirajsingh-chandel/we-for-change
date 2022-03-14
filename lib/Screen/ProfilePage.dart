import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Providers/user.dart';

import 'Registration_Page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double height, width;
  bool isSwitched = false;
  bool isSwitched2 = false;
  var _emailTextFieldController = TextEditingController();
  var _nameTextFeildController = TextEditingController();
  var _telephoneNumber = TextEditingController();
  var _addressTextFeildController = TextEditingController();
  var _roleTextFieldController = TextEditingController();

  @override
  void initState() {
    UserData user = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      _nameTextFeildController.text = user.data.name;
      _emailTextFieldController.text = user.data.email;
      _telephoneNumber.text = user.data.mobile_number;
      _addressTextFeildController.text = user.data.address;
      _roleTextFieldController.text = user.data.role;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    height = mediaQueryData.size.height;
    width = mediaQueryData.size.width;
    return new Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: HexColor("#E9EAF0"),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                margin: EdgeInsets.symmetric(vertical: 110, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor,
                ),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  new TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _nameTextFeildController,
                                    decoration: new InputDecoration(
                                      hintText: "Name",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.drive_file_rename_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  new TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _telephoneNumber,
                                    decoration: new InputDecoration(
                                      hintText: "Mobile",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.mobile_screen_share_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  new TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _addressTextFeildController,
                                    decoration: new InputDecoration(
                                      hintText: "Address",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  new TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _emailTextFieldController,
                                    decoration: new InputDecoration(
                                      hintText: "Email",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  new TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _roleTextFieldController,
                                    decoration: new InputDecoration(
                                      hintText: "Role",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  ElevatedButton(
                                    child: Text("Back"),
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(110, 40),
                                        backgroundColor: Color(0xff0C65CF)),
                                    onPressed: () {},
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            )
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
                    padding: const EdgeInsets.only(top: 50),
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
        ]))));
  }
}
