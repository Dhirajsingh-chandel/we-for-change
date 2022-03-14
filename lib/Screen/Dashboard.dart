import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/complaintData.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Providers/complaint.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/Notification.dart';
import 'package:we_for_change/widget/Drawer.dart';

import 'createComplaint.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Map<String, dynamic>> complaintList;
  List<Color> _colors = [];
  String role;
  @override
  void initState() {
    ComplaintProvider complaint =
        Provider.of<ComplaintProvider>(context, listen: false);
    UserData user = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      complaintList = complaint.getComplaint();
      role = user.data.role;
    });
    print("print compliant");
    print(complaintList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ComplaintProvider like =
        Provider.of<ComplaintProvider>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var height = mediaQueryData.size.height;
    var width = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            iconSize: 25,
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
            future: complaintList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot);
              if (snapshot.hasError) {
                return Text("No data Found");
              }
              if (snapshot.hasData) {
                print(snapshot.data['complaint']);
                ComplaintData complaintList = snapshot.data['complaint'];
                return Column(
                  children: [
                    ListView.builder(
                        physics: ClampingScrollPhysics(), // new
                        shrinkWrap: true,
                        itemCount: complaintList.data.length,
                        itemBuilder: (context, index) {
                          Uint8List bytes = Base64Decoder()
                              .convert(complaintList.data[index].image);
                          Image img = Image.memory(bytes);
                          Color isLiked =
                              complaintList.data[index].user_liked == true
                                  ? Colors.red
                                  : Colors.black;
                          return Container(
                              color: HexColor("#E9EAF0"),
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
                                                  "${complaintList.data[index].title}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image(
                                                  image: img.image,
                                                  height: 180,
                                                  width: 250,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: 1000,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                          "${complaintList.data[index].like != null ? complaintList.data[index].like : 0}"),
                                                      IconButton(
                                                        icon: Image.asset(
                                                          'assets/images/like.png',
                                                          color: isLiked,
                                                        ),
                                                        onPressed: () {
                                                          like
                                                              .likeComplaint(
                                                                  complaintList
                                                                      .data[
                                                                          index]
                                                                      .id)
                                                              // ignore: non_constant_identifier_names
                                                              .then((Response) {
                                                            if (Response[
                                                                'status']) {
                                                              setState(() {
                                                                isLiked = Response[
                                                                            'like_colour'] ==
                                                                        true
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black;
                                                                complaintList
                                                                        .data[index]
                                                                        .like =
                                                                    Response[
                                                                        'like_count'];
                                                                complaintList
                                                                        .data[index]
                                                                        .dislike =
                                                                    Response[
                                                                        'dislike_count'];
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                          "${complaintList.data[index].dislike != null ? complaintList.data[index].dislike : 0}"),
                                                      IconButton(
                                                        icon: Image.asset(
                                                            'assets/images/dislike.png'),
                                                        onPressed: () {
                                                          like
                                                              .dislikeComplaint(
                                                                  complaintList
                                                                      .data[
                                                                          index]
                                                                      .id)
                                                              // ignore: non_constant_identifier_names
                                                              .then((Response) {
                                                            if (Response[
                                                                'status']) {
                                                              setState(() {
                                                                isLiked = Response[
                                                                            'like_colour'] ==
                                                                        true
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black;
                                                                complaintList
                                                                        .data[index]
                                                                        .dislike =
                                                                    Response[
                                                                        'dislike_count'];
                                                                complaintList
                                                                        .data[index]
                                                                        .like =
                                                                    Response[
                                                                        'like_count'];
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
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
                return Text('No Posts');
              }
              return Text("data");
            }),
      ),
      floatingActionButton: role == 'User'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateComplaint()),
                );
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            )
          : null,
      drawer: MyDrawer(),
    );
  }
}
