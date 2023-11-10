import 'package:hive_flutter/hive_flutter.dart';
import 'package:miniproject/model/contacts/contacts_model.dart';

const CONTACTS_DB_NAME = 'contact_database';

abstract class ContactsDbFunctions {
  Future<void> insertContacts(ContactsModel value);
}

class ContactsDB implements ContactsDbFunctions {
  @override
  Future<void> insertContacts(ContactsModel value) async {
    final _contactDB = await Hive.openBox<ContactsModel>(CONTACTS_DB_NAME);
    await _contactDB.add(value);
  }

  @override
  Future<List<ContactsModel>> getContacts() async {
    final _contatctsDB = await Hive.openBox<ContactsModel>(CONTACTS_DB_NAME);
    return _contatctsDB.values.toList();
  }
}
