import 'package:flutter/material.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(title, style: subtitle1Style.copyWith(fontSize: 20)),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Themes.kPrimaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
