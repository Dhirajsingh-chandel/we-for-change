import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/complaintData.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Providers/complaint.dart';
import 'package:we_for_change/Providers/user.dart';

class ResolvedComplaint extends StatefulWidget {
  const ResolvedComplaint({Key key}) : super(key: key);

  @override
  _ResolvedComplaintState createState() => _ResolvedComplaintState();
}

class _ResolvedComplaintState extends State<ResolvedComplaint> {
  Future<Map<String, dynamic>> complaintList;
  String role;
  @override
  void initState() {
    ComplaintProvider complaint =
        Provider.of<ComplaintProvider>(context, listen: false);
    UserData user = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      complaintList = complaint.resolvedComplaint();
      role = user.data.role;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var height = mediaQueryData.size.height;
    var width = mediaQueryData.size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Resolved Complaints",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: complaintList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("No data Found");
              }
              if (snapshot.hasData) {
                print(snapshot.data['complaint']);
                ComplaintData complaintList = snapshot.data['complaint'];
                return Container(
                    color: HexColor("#E9EAF0"),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: complaintList.data.length,
                            itemBuilder: (context, index) {
                              String complaint_status;
                              // ignore: unrelated_type_equality_checks
                              if (complaintList.data[index].complaint_status ==
                                  2) {
                                complaint_status = 'Resolved';
                                // ignore: unrelated_type_equality_checks
                              } else if (complaintList
                                      .data[index].complaint_status ==
                                  1) {
                                complaint_status = 'In Progress';
                              } else {
                                complaint_status = 'Pending';
                              }
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
                                              elevation: 1,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Complaint Heading",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/images/g2.jpeg"),
                                                      fit: BoxFit.cover,
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
                                                            child: Text(
                                                              "Status: ${complaint_status}",
                                                            ),
                                                          )),
                                                      // child: ElevatedButton(
                                                      //     style: ButtonStyle(
                                                      //         backgroundColor:
                                                      //         MaterialStateProperty
                                                      //             .all(Colors
                                                      //             .pinkAccent)),
                                                      //     onPressed: () {},
                                                      //     child: Text(
                                                      //       "Post Complaint",
                                                      //       style: TextStyle(
                                                      //         fontSize: 20,
                                                      //       ),
                                                      //     )),
                                                    )
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
                    ));
              }
              if (snapshot.connectionState != ConnectionState.done) {
                print(snapshot.connectionState != ConnectionState.done);
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Text('No Posts');
              }
              return Text("data");
            }),
      ),
      floatingActionButton: role == 'User'
          ? FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            )
          : null,
      // drawer: MyDrawer(),
    );
  }
}
