import 'package:flutter/material.dart';
import 'package:lpg_agency_finder/models/agency_data.dart';
import 'package:lpg_agency_finder/provider/agency_provider.dart';
import 'package:lpg_agency_finder/screens/user_data.dart';
import 'package:lpg_agency_finder/widgets/agency_item.dart';
import 'package:lpg_agency_finder/widgets/scaffold.dart';
import 'package:provider/provider.dart';

enum Filters { sort, research }

class LPGList extends StatefulWidget {
  static const String routeName = '/lpg-list-screen';


  const LPGList({Key? key}) : super(key: key);

  @override
  State<LPGList> createState() => _LPGListState();
}

class _LPGListState extends State<LPGList> {
  bool sorted = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AgencyProvider>(context);
    // List<AgencyData> list = sorted ? provider.sortedList() : provider.getList();
    List<AgencyData> list = provider.dummy();
    return CustomScaffold(
      actions: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        onSelected: (Filters filter) {
          if (filter == Filters.sort) {
            setState(() {
              sorted = !sorted;
            });
          } else if (filter == Filters.research) {
            Navigator.of(context)
                .pushReplacementNamed(UserDataScreen.routeName);
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(
            value: Filters.sort,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Sort Alphabetically'),
                Icon(Icons.sort_by_alpha),
              ],
            ),
          ),
          const PopupMenuItem(
            value: Filters.research,
            child: Text('Re-enter location'),
          )
        ],
      ),
      widget: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: list[i],
          child: AgencyItem(agency: list[i]),
        ),
        padding: const EdgeInsets.all(10),
        itemCount: list.length,
      ),
    );
  }
}
