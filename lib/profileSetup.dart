import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'homePage.dart';

class profileSetup extends StatefulWidget {
  const profileSetup({super.key});

  @override
  State<profileSetup> createState() => _profileSetupState();
}

class _profileSetupState extends State<profileSetup> {
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SecureMe',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            //height: double.infinity,
            margin: EdgeInsets.only(left: 30, top: 100, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Complete Your Profile',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 60)),
                Ink(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        )),
                  ),
                  child: IconButton(
                    iconSize: 80,
                    onPressed: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Choose a Profile photo',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Material(
                                            type: MaterialType.transparency,
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                //border: Border.all(width: 1),
                                                color: Colors.transparent,
                                              ),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.pink,
                                                  size: 80,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Material(
                                            type: MaterialType.transparency,
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.insert_photo_outlined,
                                                  color: Colors.pink,
                                                  size: 80,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Gallery',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.camera),
                                          label: Text(
                                            'Camera',
                                            style: TextStyle(fontSize: 20),
                                          )),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.image),
                                          label: Text(
                                            'Gallery',
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.grey,
                      //size: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                Container(
                  //padding: EdgeInsets.only(left: 70),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Username',
                    //textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blue,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                          title: Text(
                            'Male',
                            style: TextStyle(fontSize: 18),
                          ),
                          contentPadding: EdgeInsets.all(0.0),
                          value: "Male",
                          groupValue: gender,
                          onChanged: ((value) {
                            setState(() {
                              gender = value.toString();
                            });
                          })),
                    ),
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                          title: Text(
                            'Female',
                            style: TextStyle(fontSize: 18),
                          ),
                          contentPadding: EdgeInsets.all(0.0),
                          value: "Female",
                          groupValue: gender,
                          onChanged: ((value) {
                            setState(() {
                              gender = value.toString();
                            });
                          })),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RadioListTile(
                          title: Text(
                            'Other',
                            style: TextStyle(fontSize: 18),
                          ),
                          contentPadding: EdgeInsets.all(0.0),
                          value: "Other",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          }),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'HomeScreen');
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )),
                Padding(padding: EdgeInsets.only(bottom: 30))
              ],
            ),
          ),
        ));
  }
}
