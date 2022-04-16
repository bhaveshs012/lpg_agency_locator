import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpg_agency_locator/views/homeScreen/homescreen.dart';

class TopImageCard extends StatelessWidget {
  const TopImageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned(
          child: Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/cover.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.softLight),
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => (Get.off(() => HomeScreen())),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
