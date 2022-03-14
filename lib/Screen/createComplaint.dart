import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Providers/complaint.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/Dashboard.dart';

class CreateComplaint extends StatefulWidget {
  @override
  _CreateComplaintState createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  LocationData _currentPosition;
  String _address, _dateTime;
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();

  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  var picker = ImagePicker();
  var _value;
  File _image;
  _imgFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final _addressTextFieldController = TextEditingController();
  final _titleTextFieldController = TextEditingController();
  final _descriptionTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ComplaintProvider complaint = Provider.of<ComplaintProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Create Complaint",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Container(
              color: HexColor("#E9EAF0"),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 7.5,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: _initialcameraposition, zoom: 15),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: false,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      elevation: 1,
                      child: Column(
                        children: [
                          Text(
                            "Current Location:",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          if (_address != null) SizedBox(height: 10),
                          new TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _addressTextFieldController,
                            maxLines: null,
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                              child: Text(
                            "Title:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 1,
                            child: new TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _titleTextFieldController,
                              maxLines: null,
                              decoration: new InputDecoration(
                                hintText: "Title",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                prefixIcon: Icon(
                                  Icons.location_history,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Photo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _image == null
                              ? GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                    // imagePicker(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff0C65CF),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    radius: 50,
                                  ))
                              : Image.file(
                                  _image,
                                  width: 180.0,
                                  height: 180.0,
                                  fit: BoxFit.fill,
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _descriptionTextFieldController,
                            maxLines: null,
                            decoration: new InputDecoration(
                              hintText: "More info",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Material(
                              shadowColor: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              elevation: 1,
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButton(
                                      value: _value,
                                      isExpanded: true,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.deepPurple,
                                      ),
                                      hint: Text(
                                        "Nature of Complaint",
                                        // style: GoogleFonts.ptSans(
                                        //   textStyle: TextStyle(
                                        //     color: Colors.grey,
                                        //     fontSize: 20,
                                        //   ),
                                        //   color: Colors.grey,
                                        // ),
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
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () async {
                              print(_image);
                              complaint
                                  .createComplaint(
                                      _addressTextFieldController.text,
                                      _titleTextFieldController.text,
                                      _descriptionTextFieldController.text,
                                      _image,
                                      _value)
                                  .then((response) {
                                if (response['status']) {
                                  Fluttertoast.showToast(
                                      msg: response['message'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
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
                                      backgroundColor: Colors.red,
                                      textColor: Colors.yellow);
                                }
                              });
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
            _addressTextFieldController.text = _address;
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
}
