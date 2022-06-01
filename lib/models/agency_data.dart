import 'package:flutter/cupertino.dart';

class AgencyData with ChangeNotifier {
  final String id;
  final String name;
  final String contact;
  final double cost;
  final String address;
  final double longitude;
  final double latitude;

  AgencyData({
    required this.id,
    required this.name,
    required this.contact,
    required this.cost,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'address': address,
      'cost': cost.toString(),
      'longitude': longitude.toString(),
      'latitude': latitude.toString(),
    };
  }

  static AgencyData fromMap(Map<String, dynamic> map){
    return AgencyData(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      address: map['address'],
      cost: double.parse(map['cost'].toString()),
      longitude: double.parse(map['longitude'].toString()),
      latitude: double.parse(map['latitude'].toString()),
    );
  }

}
