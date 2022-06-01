import 'package:flutter/material.dart';
import 'package:lpg_agency_finder/models/agency_data.dart';

class AgencyItem extends StatelessWidget{
  const AgencyItem({Key? key, required this.agency}) : super(key: key);
  final AgencyData agency;

  @override
  Widget build(BuildContext context) {
    final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20),),
        color: darkMode?Colors.black26:Colors.white70
      ),
      width: screenSize.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            agency.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            agency.address,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            agency.contact,
            style: const TextStyle(
                fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${agency.cost}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                onTap: ()=>{},
                splashColor: Colors.white70,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                    color: Colors.blueAccent
                  ),
                  child: const Text('Book Now'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}