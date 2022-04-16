import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';
import 'package:lpg_agency_locator/models/agency.dart';
import 'package:lpg_agency_locator/views/agencyDetailsScreen/agency_details_screen.dart';
import 'package:lpg_agency_locator/views/homeScreen/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

class AgencyDisplayCard extends StatelessWidget {
  const AgencyDisplayCard({
    Key? key,
    required this.agency,
  }) : super(key: key);
  final Agency agency;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AgencyDetailsScreen(agency: agency));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: 35.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/cover.jpg',
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          agency.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: title3Style.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          agency.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: subtitle1Style.copyWith(
                            fontSize: 10.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          agency.address,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: subtitle1Style.copyWith(
                            fontSize: 10.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomButton(
                        title: 'View More',
                        onTap: () {},
                        bgColor: Themes.kPrimaryColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
