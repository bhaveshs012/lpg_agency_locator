import 'package:flutter/material.dart';
import 'package:lpg_agency_locator/config/fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.textColor,
    required this.bgColor,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: subtitle3Style.copyWith(color: textColor),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(bgColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
