import 'package:hive_flutter/hive_flutter.dart';
part 'contacts_model.g.dart';

@HiveType(typeId: 2)
class ContactsModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final double latitude;
  @HiveField(3)
  final double longitude;

  ContactsModel(
      {required this.name,
      required this.phone,
      required this.latitude,
      required this.longitude});

  @override
  String toString() {
    return '$name $phone $latitude $longitude';
  }
}
