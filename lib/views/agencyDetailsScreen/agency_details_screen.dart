import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/models/agency.dart';
import 'package:lpg_agency_locator/views/agencyDetailsScreen/widgets/top_image_card.dart';
import 'package:lpg_agency_locator/views/mapScreen/map_screen.dart';
import 'package:lpg_agency_locator/views/sharedWidgets/styled_button.dart';
import 'package:sizer/sizer.dart';

class AgencyDetailsScreen extends StatelessWidget {
  const AgencyDetailsScreen({Key? key, required this.agency}) : super(key: key);

  final Agency agency;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopImageCard(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      agency.name,
                      style: title2Style,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      agency.description,
                      style: subtitle3Style,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Address: ',
                      style: title3Style,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      agency.address + ", " + agency.pincode,
                      style: subtitle3Style,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: StyledButton(
                        title: 'Get Directions',
                        onTap: () {
                          Get.to(MapScreen(
                            agency: agency,
                          ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
