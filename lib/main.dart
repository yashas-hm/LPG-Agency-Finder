import 'package:flutter/material.dart';
import 'package:lpg_agency_finder/provider/agency_provider.dart';
import 'package:lpg_agency_finder/screens/lpg_list.dart';
import 'package:lpg_agency_finder/screens/user_data.dart';
import 'package:lpg_agency_finder/widgets/scaffold.dart';
import 'package:lpg_agency_finder/widgets/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AgencyProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const MyHomePage(),
        routes: {
          UserDataScreen.routeName: (ctx) => UserDataScreen(),
          LPGList.routeName: (ctx) => const LPGList(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(widget: Splash());
    // return LPGList();
  }
}
