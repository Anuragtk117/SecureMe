import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniproject/db/users/users_db.dart';
import 'package:miniproject/logIn.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import 'db/contacts/contacts_db.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late TwilioFlutter twilioFlutter;
  static const LatLng _pGooglePlex = LatLng(11.6016, 75.5920);
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    twilioFlutter =
        TwilioFlutter(accountSid: '', authToken: '', twilioNumber: '');
    super.initState();
  }

  void sendSms() async {
    Position position = await Geolocator.getCurrentPosition();
    var num = await findPerson();
    print(num);
    var lat = position.latitude;
    var longi = position.longitude;
    twilioFlutter.sendSMS(
        toNumber: num,
        messageBody:
            '\n\n\n I am in a trouble please help me \n https://www.google.com/maps/search/?api=1&query=$lat,$longi');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);
    await twilioFlutter.getSMS('***************************');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: Text(
                  'Do you want to Exit ?',
                  style: TextStyle(color: Colors.white),
                ),
                //content:
                actions: [
                  Container(
                    margin: EdgeInsets.only(left: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Exit')),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10))
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'SecureMe',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx1) => LogIn()),
                      (route) => false);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            onPressed: sendSms,
            tooltip: 'Send Sms',
            child: Icon(
              Icons.sos_rounded,
              size: 60,
            ),
            backgroundColor: Colors.red,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            notchMargin: 5.0,
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Position position = await _determinePosition();
                          googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                      position.latitude, position.longitude),
                                  zoom: 18)));

                          markers.clear();
                          markers.add(Marker(
                              markerId: const MarkerId("currentLocation"),
                              position: LatLng(
                                  position.latitude, position.longitude)));
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_searching,
                              size: 30.0,
                              color: Colors.pink,
                            ),
                            Text(
                              'Track Me ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'AddContact');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 30.0,
                              color: Colors.pink,
                            ),
                            Text(
                              'Contacts ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _pGooglePlex,
            zoom: 10,
          ),
          zoomControlsEnabled: false,
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<String> findPerson() async {
    Position current = await Geolocator.getCurrentPosition();
    var index = 0;
    var value = await ContactsDB().getContacts();
    double min = 0;
    double distance = 0;
    for (var i = 0; i < value.length; i++) {
      distance = Geolocator.distanceBetween(current.latitude, current.longitude,
          value[i].latitude, value[i].longitude);
      if (i == 0) {
        min = distance;
      } else if (min > distance) {
        min = distance;
        index = i;
      }
    }
    var mob = "+91" + value[index].phone;

    return mob;
  }
}
