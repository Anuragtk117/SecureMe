import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:miniproject/db/contacts/contacts_db.dart';
import 'package:miniproject/db/users/users_db.dart';
import 'package:miniproject/model/contacts/contacts_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniproject/model/users/user_model.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                submitButtonClicked();
              },
              child: Text('Add Contacts'),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            ElevatedButton(
                onPressed: () {
                  // final _contact = Hive.openBox<ContactsModel>(CONTACTS_DB_NAME);
                  // Hive.deleteFromDisk();
                  final _user = Hive.openBox<Usersmodel>(USERS_DB_NAME);
                  Hive.deleteFromDisk();
                  Navigator.pushNamed(context, 'HomeScreen');
                },
                child: Text('clear Contacts'))
          ],
        ),
      ),
    );
  }

  Future<void> submitButtonClicked() async {
    final _addContact1 = ContactsModel(
        name: 'Aswin',
        phone: '**********',
        latitude: 11.608495,
        longitude: 75.591705);
    final _addContact2 = ContactsModel(
        name: 'Ajay',
        phone: '**********',
        latitude: 11.981863,
        longitude: 75.670265);
    final _addContact3 = ContactsModel(
        name: 'Manu',
        phone: '*********',
        latitude: 12.420353,
        longitude: 75.023148);
    final _addContact4 = ContactsModel(
        name: 'Farhathulla',
        phone: '***********',
        latitude: 11.072035,
        longitude: 76.074005);
    final _addContact5 = ContactsModel(
        name: 'Ishaque',
        phone: '********',
        latitude: 11.258753,
        longitude: 75.780411);
    final _addContact6 = ContactsModel(
        name: 'Prathul',
        phone: '*******',
        latitude: 11.69025,
        longitude: 76.11885);
    final _addContact7 = ContactsModel(
        name: 'Jishnu',
        phone: '**********',
        latitude: 11.874477,
        longitude: 75.370369);
    final _addContact8 = ContactsModel(
        name: 'Akshay',
        phone: '********',
        latitude: 12.1050687,
        longitude: 75.2058336);
    final _addContact9 = ContactsModel(
        name: 'Navaneeth',
        phone: '*********',
        latitude: 16.640120,
        longitude: 74.145874);
    final _addContact10 = ContactsModel(
        name: 'Aswanth',
        phone: '********',
        latitude: 11.748050,
        longitude: 75.489380);

    ContactsDB().insertContacts(_addContact1);
    ContactsDB().insertContacts(_addContact2);
    ContactsDB().insertContacts(_addContact3);
    ContactsDB().insertContacts(_addContact4);
    ContactsDB().insertContacts(_addContact5);
    ContactsDB().insertContacts(_addContact6);
    ContactsDB().insertContacts(_addContact7);
    ContactsDB().insertContacts(_addContact8);
    ContactsDB().insertContacts(_addContact9);
    ContactsDB().insertContacts(_addContact10);
    Navigator.pushNamed(context, 'firstpage');
  }

  Future<int> findPerson() async {
    Position current = await Geolocator.getCurrentPosition();
    double dist = 0;
    var index;
    var mob;
    ContactsDB().getContacts().then((value) {
      for (var i = 0; i < value.length; i++) {
        double distance = Geolocator.distanceBetween(current.latitude,
            current.longitude, value[0].latitude, value[0].longitude);

        if (distance <= dist) {
          dist = distance;
          index = i;
        }
      }
      mob = value[index].phone;
    });

    return mob;
  }
}
