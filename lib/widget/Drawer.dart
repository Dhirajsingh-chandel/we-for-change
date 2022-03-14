import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Models/userData.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/AddAdmin.dart';
import 'package:we_for_change/Screen/ContactUs.dart';
import 'package:we_for_change/Screen/Dashboard.dart';
import 'package:we_for_change/Screen/ProfilePage.dart';
import 'package:we_for_change/Screen/Registration_Page.dart';
import 'package:we_for_change/Screen/UpdateComplaint.dart';
import 'package:we_for_change/Screen/createComplaint.dart';
import 'package:we_for_change/Screen/myComplaint.dart';
import 'package:we_for_change/Screen/resolvedComplaint.dart';
import 'package:we_for_change/Utils/SharedPreferencesHelper.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String role, name, mobile, email;
  @override
  void initState() {
    UserData user = Provider.of<UserProvider>(context, listen: false).user;
    setState(() {
      name = user.data.name;
      mobile = user.data.mobile_number;
      email = user.data.email;
      getRole();
    });
    super.initState();
  }

  getRole() async {
    String roleName;
    roleName = await SharedPreferencesHelper.getRole();
    print(roleName);
    return roleName;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    return Drawer(
      child: FutureBuilder(
          future: getRole(),
          builder: (context, role) {
            return Container(
                decoration: new BoxDecoration(
                    color: HexColor("#E9EAF0"),
                    border: new Border(bottom: new BorderSide())),
                child: getMenu(role.data, name, mobile, email, user));
          }),
    );
  }

  Widget getMenu(
      role, String name, String mobile, String email, UserProvider user) {
    switch (role) {
      case ('User'):
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // do something
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$email",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$mobile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 28,
                            child: TextButton(
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (Color(0xff0C65CF)))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                );
                                // do something
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: Text(
                  "DashBoard",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading:
                    const Icon(Icons.menu_book_outlined, color: Colors.black),
                title: Text(
                  "Complaints",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateComplaint(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "My Complaints",
                  // textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyComplaint(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Resolved Complaints",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResolvedComplaint()),
                  );
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(
                  Icons.headset_mic_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(
                  Icons.share_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Refer a Friend",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Share.share("https://play.google.com/store/apps/details?id=com.durity&hl=en_IN");
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  user.logout();
                  SharedPreferencesHelper.setAuthToken(null);
                  SharedPreferencesHelper.removeData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
              ),
            ),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
          ],
        );
        break;
      case ('Super Admin'):
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // do something
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$email",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$mobile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 28,
                            child: TextButton(
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (Color(0xff0C65CF)))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                );
                                // do something
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: Text(
                  "DashBoard",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(Icons.person_add, color: Colors.black),
                title: Text(
                  "Add Admin",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAdmin(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Resolved Your Work",
                  // textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateComplaint(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Resolved Complaints",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResolvedComplaint()),
                  );
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(Icons.notifications, color: Colors.black),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  user.logout();
                  SharedPreferencesHelper.setAuthToken(null);
                  SharedPreferencesHelper.removeData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
              ),
            ),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
          ],
        );
        break;
      case ("Admin"):
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // do something
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$email",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "$mobile",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 28,
                            child: TextButton(
                              child: Text(
                                "My Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (Color(0xff0C65CF)))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                );
                                // do something
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: Text(
                  "DashBoard",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Resolve Your Work",
                  // textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateComplaint(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Resolved Complaints",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResolvedComplaint()),
                  );
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            ListTile(
                leading: const Icon(Icons.notifications, color: Colors.black),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ));
                }),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  user.logout();
                  SharedPreferencesHelper.setAuthToken(null);
                  SharedPreferencesHelper.removeData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
              ),
            ),
            Divider(
              height: 0.1,
              thickness: 1,
            ),
          ],
        );
        break;
    }
  }
}
