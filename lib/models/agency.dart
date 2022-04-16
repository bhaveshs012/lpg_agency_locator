import 'package:cloud_firestore/cloud_firestore.dart';

class Agency {
  final String name;

  final String id;
  final String description;
  final String address;
  final String pincode;
  final GeoPoint position;
  Agency({
    required this.name,
    required this.id,
    required this.description,
    required this.address,
    required this.pincode,
    required this.position,
  });
}
