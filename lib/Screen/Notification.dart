import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/complaintData.dart';
import 'package:we_for_change/Models/notificationData.dart';
import 'package:we_for_change/Providers/notificationPro.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<Map<String, dynamic>> notificationList;
  @override
  void initState() {
    NotificationProvider notification =
        Provider.of<NotificationProvider>(context, listen: false);
    setState(() {
      notificationList = notification.notifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotificationProvider updateNotifications =
        Provider.of<NotificationProvider>(context);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var height = mediaQueryData.size.height;
    var width = mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: HexColor("#E9EAF0"),
        child: FutureBuilder<Object>(
            future: notificationList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("No data Found12");
              }
              if (snapshot.hasData) {
                print(snapshot.data['notification']);
                NotificationData notificationList =
                    snapshot.data['notification'];
                return Column(
                  children: [
                    Expanded(
                      child: Material(
                        borderRadius: BorderRadius.circular(18),
                        color: HexColor("#E9EAF0"),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: notificationList != null
                                ? notificationList.data.length
                                : 1,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80,
                                  child: GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 2,
                                      color: notificationList != null
                                          ?
                                          // ignore: unrelated_type_equality_checks
                                          notificationList.data[index].status ==
                                                  false
                                              ? Colors.lightBlue
                                              : Colors.white
                                          : Colors.white,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.notifications,
                                              ),
                                              iconSize: 30,
                                              color: Colors.black,
                                              onPressed: () {},
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  notificationList != null
                                                      ? "${notificationList.data[index].message}"
                                                      : "No Notifications",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      updateNotifications.seenNotifications(
                                          notificationList.data[index].id);
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
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
    );
  }
}
