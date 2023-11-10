import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniproject/homePage.dart';
import 'package:miniproject/model/contacts/contacts_model.dart';
import 'package:miniproject/model/users/user_model.dart';
import 'package:miniproject/splashScreen.dart';

import 'addContacts.dart';
import 'firstPage.dart';
import 'logIn.dart';
import 'signUp.dart';
import 'otpVerification.dart';
import 'profile.dart';

const PHONE_KEY = 'Phone number';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UsersmodelAdapter().typeId)) {
    Hive.registerAdapter(UsersmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(ContactsModelAdapter().typeId)) {
    Hive.registerAdapter(ContactsModelAdapter());
  }

  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink,
      ),
      home: splashScreen(),
      routes: {
        'firstpage': (context) => firstPage(),
        'LogIn': (context) => LogIn(),
        'SignUp': (context) => SignUp(),
        'OtpVerification': (context) => otpVerification(),
        'ProfileSetup': (context) => ProfileFirst(),
        'HomeScreen': (context) => homePage(),
        'AddContact': (context) => AddContact(),
      },
    );
  }
}
