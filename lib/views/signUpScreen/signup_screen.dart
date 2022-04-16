import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as lt;
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';
import 'package:lpg_agency_locator/controllers/location.dart';
import 'package:lpg_agency_locator/views/homeScreen/homescreen.dart';
import 'package:lpg_agency_locator/views/landing_screen.dart';
import 'package:lpg_agency_locator/views/sharedWidgets/styled_button.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

bool _passwordVisible = false;
String _name = '';
String _email = '';
String _password = '';
String _phoneNumber = '';
String country = '';
String name = '';
String postalCode = '';
String area = '';
String city = '';
String subArea = '';
TextEditingController _addressController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);
    setState(() {
      country = placemark[0].country!;
      name = placemark[0].subLocality!;
      city = placemark[0].locality!;
      subArea = placemark[0].subAdministrativeArea!;
      area = placemark[0].administrativeArea!;
      postalCode = placemark[0].postalCode!;
    });
    print(placemark[0].subLocality);
    print(placemark[0].subAdministrativeArea);
  }

  Future<void> locationService() async {
    lt.Location location = lt.Location();

    bool _serviceEnabled;
    lt.PermissionStatus _permissionLocation;
    lt.LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == lt.PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != lt.PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });
    getLocation();
    // Timer(const Duration(milliseconds: 10000), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: title1Style,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* name text field
                  TextFormField(
                    style: subtitle1Style.copyWith(fontSize: 18),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor),
                      ),
                      hintText: "Enter your Name",
                      hintStyle: subtitle2Style.copyWith(color: Colors.black45),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value.trim();
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* email text field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: subtitle1Style.copyWith(fontSize: 18),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor),
                      ),
                      hintText: "Enter your Email",
                      hintStyle: subtitle2Style.copyWith(color: Colors.black45),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* password text field
                  TextFormField(
                    style: subtitle1Style.copyWith(fontSize: 18),
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor),
                      ),
                      hintText: "Enter your Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                          // print("Password Visibility: $_passwordVisible");
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Themes.kPrimaryColor,
                        ),
                      ),
                      hintStyle: subtitle2Style.copyWith(color: Colors.black45),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* Phone Number text field
                  TextFormField(
                    style: subtitle1Style.copyWith(fontSize: 18),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('+91',
                            style:
                                subtitle1Style.copyWith(color: Colors.black)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor),
                      ),
                      hintText: "Enter your Phone Number",
                      hintStyle: subtitle2Style.copyWith(color: Colors.black45),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value.trim();
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* Address text Field
                  TextFormField(
                    controller: _addressController,
                    style: subtitle1Style.copyWith(fontSize: 18),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            locationService();
                            _addressController.text =
                                "$name, $city, $subArea, $area, $country, $postalCode";
                            print(_addressController.text);
                          });
                        },
                        icon: Icon(
                          Icons.location_searching_rounded,
                          color: Themes.kPrimaryColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor),
                      ),
                      hintText: "Enter your Address",
                      hintStyle: subtitle2Style.copyWith(color: Colors.black45),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  //* email Signup button
                  Center(
                    child: StyledButton(
                      title: "Sign Up",
                      onTap: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                          User? updateUser = FirebaseAuth.instance.currentUser;
                          FirebaseAuth.instance.currentUser!
                              .updateDisplayName(_name);
                          FirebaseAuth.instance.currentUser!
                              .updatePhotoURL("NAN");
                          var ref = FirebaseFirestore.instance
                              .collection("users")
                              .doc(userCredential.user!.uid);
                          ref.get().then((value) {
                            if (!value.exists) {
                              ref.set({
                                "name": _name,
                                "email": userCredential.user!.email,
                                "photoUrl": "NAN",
                                'id': userCredential.user!.uid,
                                'phoneNumber': _phoneNumber,
                                'address': _addressController.text,
                              });
                            }
                          });
                          Get.to(() => const LandingPage());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            Get.snackbar(
                                "Weak Password", "Use a better password");
                          } else if (e.code == 'email-already-in-use') {
                            Get.snackbar("Account already exists",
                                'The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "By signing up, you agree to our\nterms and conditions\nand our privacy policy",
                    style: subtitle2Style.copyWith(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
