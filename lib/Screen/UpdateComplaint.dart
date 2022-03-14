import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/complaintData.dart';
import 'package:we_for_change/Providers/complaint.dart';

import 'createComplaint.dart';

class UpdateComplaint extends StatefulWidget {
  const UpdateComplaint({Key key}) : super(key: key);

  @override
  _UpdateComplaintState createState() => _UpdateComplaintState();
}

class _UpdateComplaintState extends State<UpdateComplaint> {
  Future<Map<String, dynamic>> complaintList;
  var _value;
  @override
  void initState() {
    ComplaintProvider complaint =
        Provider.of<ComplaintProvider>(context, listen: false);
    setState(() {
      complaintList = complaint.getDeptComplaint();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ComplaintProvider complaint = Provider.of<ComplaintProvider>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var height = mediaQueryData.size.height;
    var width = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: HexColor("#E9EAF0"),
        title: Text(
          "Complaints",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
            future: complaintList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("No data Found");
              }
              if (snapshot.hasData) {
                print(snapshot.data['complaint']);
                ComplaintData complaintList = snapshot.data['complaint'];

                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: complaintList.data.length,
                        itemBuilder: (context, index) {
                          Uint8List bytes = Base64Decoder()
                              .convert(complaintList.data[index].image);
                          Image img = Image.memory(bytes);
                          String complaintStatus;
                          // ignore: unrelated_type_equality_checks
                          if (complaintList.data[index].complaint_status == 2) {
                            complaintStatus = 'Resolved';
                            // ignore: unrelated_type_equality_checks
                          } else if (complaintList
                                  .data[index].complaint_status ==
                              1) {
                            complaintStatus = 'In Progress';
                          } else {
                            complaintStatus = 'Pending';
                          }
                          print(index);
                          // _value[index] =
                          // complaintList.data[index].complaint_status;

                          return Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              height: 300,
                              width: double.maxFinite,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Card(
                                          elevation: 2,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${complaintList.data[index].title}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Image(
                                                  image: img.image,
                                                  height: 180,
                                                  width: 250,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                    width: 1000,
                                                    height: 50,
                                                    child: Card(
                                                      elevation: 0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Status: ",
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  DropdownButtonHideUnderline(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  child: DropdownButton(
                                                                      value: complaintList.data[index].complaint_status,
                                                                      isExpanded: true,
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: Colors
                                                                            .deepPurple,
                                                                      ),
                                                                      hint: Text(
                                                                        "Select Status",
                                                                      ),
                                                                      iconSize: 24,
                                                                      items: [
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Pending"),
                                                                          value:
                                                                              0,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("In Progress"),
                                                                          value:
                                                                              1,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("Resolved"),
                                                                          value:
                                                                              2,
                                                                        ),
                                                                      ],
                                                                      onChanged: (value) {
                                                                        setState(
                                                                            () {
                                                                          complaintList
                                                                              .data[index]
                                                                              .complaint_status = value;
                                                                          complaint
                                                                              .updateComplaint(value, complaintList.data[index].id)
                                                                              .then((response) {
                                                                            if (response['status']) {
                                                                              print(response['complaint_status']);
                                                                              print("----------------------------------");
                                                                              complaintList.data[index].complaint_status = response['complaint_status'];
                                                                              Fluttertoast.showToast(msg: response['message'], toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.white, textColor: Colors.green);
                                                                            }
                                                                          });
                                                                        });
                                                                      }),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  // Course(),
                                ],
                              ));
                        })
                  ],
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                print(snapshot.connectionState != ConnectionState.done);
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Text('No Complaint');
              }
              return Text("No Complaint Yet");
            }),
      ),
    );
  }
}
