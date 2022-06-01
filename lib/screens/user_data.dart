import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lpg_agency_finder/models/user.dart';
import 'package:lpg_agency_finder/provider/agency_provider.dart';
import 'package:lpg_agency_finder/screens/lpg_list.dart';
import 'package:lpg_agency_finder/utils/utils.dart';
import 'package:lpg_agency_finder/widgets/scaffold.dart';
import 'package:provider/provider.dart';

class UserDataScreen extends StatelessWidget {
  static const routeName = '/user_data_screen';

  UserDataScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> dataMap = {};

  @override
  Widget build(BuildContext context) {
    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return CustomScaffold(
      widget: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: screenSize.width * 3 / 4,
            height: screenSize.height / 2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: darkMode ? Colors.black26 : Colors.white70,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Contact',
                      hintText: 'Enter your phone number',
                    ),
                    onSaved: (value) => dataMap['contact'] = value ?? '',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width / 2,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          textInputAction: TextInputAction.done,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            hintText: 'Enter full address',
                          ),
                          onSaved: (value) => dataMap['address'] = value ?? '',
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.white70,
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (ctx) {
                                return FutureBuilder(
                                  future: Location().getLocation(),
                                  builder: (c, s) {
                                    if (s.connectionState ==
                                        ConnectionState.done) {
                                      final location = s.data as LocationData;
                                      dataMap['latitude'] = location.latitude!;
                                      dataMap['longitude'] =
                                          location.longitude!;
                                      Navigator.of(ctx).pop();
                                    }
                                    return AlertDialog(
                                      title: const Text('Fetching Data'),
                                      content: SizedBox(
                                        height: screenSize.height / 3,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          height: screenSize.width / 10,
                          width: screenSize.width / 10,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.blueAccent),
                          child: const Icon(Icons.gps_fixed),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () => {},
                      //   icon: const Icon(Icons.gps_fixed),
                      //   color: Colors.blueAccent,
                      //   iconSize: 30,
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => searchProvider(context),
                    child: Container(
                      height: 40,
                      width: screenSize.width / 3,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Colors.blueAccent),
                      child: const Text('Search'),
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

  void searchProvider(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    formKey.currentState!.save();
    if (dataMap['contact'].toString().isEmpty ||
        dataMap['contact'].toString().length < 10) {
      Utils.errorSnackbar(context, 'Invalid Contact');
    } else if (dataMap['address'].toString().isEmpty) {
      Utils.errorSnackbar(context, 'Invalid Address');
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return FutureBuilder(
            future: Utils.latLongFromAddress(dataMap['address']),
            builder: (c, s) {
              if (s.connectionState == ConnectionState.done) {
                if (dataMap['latitude'] == null) {
                  final location = s.data as List<double>;
                  dataMap['latitude'] = location[0];
                  dataMap['longitude'] = location[1];
                }

                final user = User(
                  contact: dataMap['contact'],
                  address: dataMap['address'],
                  latitude: dataMap['latitude'],
                  longitude: dataMap['longitude'],
                );

                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    Provider.of<AgencyProvider>(context, listen: false)
                        .setUser(user);
                    Navigator.of(ctx).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(LPGList.routeName);
                  },
                );
              }
              return AlertDialog(
                content: SizedBox(
                  height: screenSize.height / 3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
