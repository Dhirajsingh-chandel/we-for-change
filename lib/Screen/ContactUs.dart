import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: Colors.grey[100],
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
                backgroundColor: Colors.grey[100],
                elevation: 0.0,
                leadingWidth: 80,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 11),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey[100],
                      size: 20,
                    ),
                    label: Text(
                      "Back",
                      style: TextStyle(color: Colors.grey[100], fontSize: 14),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      HexColor('#FD6A0F'),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // do something
                    },
                  ),
                ),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: new Text(
                    "Contact Us",
                    style: new TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.home,
                      color: Colors.deepOrange,
                      size: 35,
                    ),
                  ),
                ]),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 40),
                    child: SizedBox(
                      height: 40,
                      width: 340,
                      child: TextField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.red, width: 0.0)),
                          hintText: "Enter Email Id",
                          hintStyle: TextStyle(fontSize: 12),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 10),
                    child: SizedBox(
                      height: 40,
                      width: 340,
                      child: TextField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.red, width: 0.0)),
                          hintText: "What This About",
                          hintStyle: TextStyle(fontSize: 12),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 10),
                    child: TextFormField(
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          )),
                          hintText: "Go ahead, we're listening..",
                          hintStyle: TextStyle(fontSize: 12)),
                      minLines:
                          10, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 240, top: 20, right: 20),
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff0C65CF),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
