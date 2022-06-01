import 'package:flutter/material.dart';
import 'package:lpg_agency_finder/models/user.dart';
import 'package:lpg_agency_finder/utils/db_helper.dart';
import 'package:lpg_agency_finder/utils/utils.dart';

import '../models/agency_data.dart';

class AgencyProvider with ChangeNotifier {
  final List<AgencyData> list = [];

  User? user;

  AgencyProvider(){
    DBHelper.getList();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  List<AgencyData> dummy() {
    final l = <AgencyData>[];
    for (int i = 0; i < 10; i++) {
      l.add(
        AgencyData(
          id: '${i + 1}',
          name: 'lorem ipsum',
          contact: '0000000000',
          cost: 100.0,
          address: 'Lorem Ipsum Venti centi larvae casua vernam zeta orisis',
          longitude: 0.0,
          latitude: 0.0,
        ),
      );
    }
    return l;
  }

  List<AgencyData> sortedList() {
    final l = getList();
    l.sort((a, b) => a.name.compareTo(b.name));
    return l;
  }

  List<AgencyData> getList() => [...list]
      .where((element) =>
          Utils.distanceFromUser(user!.latitude, user!.longitude,
              element.latitude, element.longitude) <=
          50)
      .toList();
}
