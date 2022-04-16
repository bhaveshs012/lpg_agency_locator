import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';
import 'package:lpg_agency_locator/controllers/google_signin.dart';
import 'package:lpg_agency_locator/views/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);
  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: imageUrl == "NAN"
              ? Image.asset('assets/images/avatar.png').image
              : Image.network(imageUrl).image,
          radius: 30,
        ),
        const SizedBox(width: 10),
        Container(
          width: 55.w,
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: 'Hello',
              style: subtitle1Style.copyWith(
                fontWeight: FontWeight.normal,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' $name',
                  style: title2Style.copyWith(
                    color: Themes.kPrimaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.GoogleLogOut()
                  .then((value) => Get.offAll(const LandingPage()));
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ))
      ],
    );
  }
}
