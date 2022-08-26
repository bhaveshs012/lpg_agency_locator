import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';
import 'package:lpg_agency_locator/controllers/location.dart';
import 'package:lpg_agency_locator/models/agency.dart';
import 'package:lpg_agency_locator/views/homeScreen/widgets/agency_display_card.dart';
import 'package:lpg_agency_locator/views/homeScreen/widgets/top_row.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationService();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<DocumentSnapshot>> stream = Geoflutterfire()
        .collection(
            collectionRef: FirebaseFirestore.instance.collection('agencies'))
        .within(
            center: Geoflutterfire().point(
                latitude: UserLocation.lat, longitude: UserLocation.long),
            radius: 20,
            field: 'position',
            strictMode: true);

    stream.listen((List<DocumentSnapshot> documentList) {});

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopRow(
                name: FirebaseAuth.instance.currentUser!.displayName.toString(),
                imageUrl:
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Nearby Agencies',
                style: title1Style,
              ),
              SizedBox(
                height: 5.h,
              ),
              StreamBuilder<List<DocumentSnapshot>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List agenciesList = [];
                    snapshot.data!.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      agenciesList.add(a);
                      a['id'] = document.id;
                    }).toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 33.h,
                            child: AgencyDisplayCard(
                              agency: Agency(
                                name: agenciesList[index]['name'],
                                id: agenciesList[index]['id'],
                                position: agenciesList[index]['position']
                                    ['geopoint'],
                                address: agenciesList[index]['address'],
                                pincode: agenciesList[index]['pincode'],
                                description: agenciesList[index]['description'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// AgencyDisplayCard(
                //   agency: Agency(
                //     name: 'LPG Agency',
                //     imageUrl:
                //         'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
                //     id: '1',
                //     description:
                //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                //     address: 'LPG Agency',
                //     pincode: 'LPG Agency',
                //     position: GeoPoint(15.001, 16.001),
                //   ),
                // ),

