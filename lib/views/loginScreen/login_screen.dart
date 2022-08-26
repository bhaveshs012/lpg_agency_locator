import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/config/theme.dart';
import 'package:lpg_agency_locator/controllers/google_signin.dart';
import 'package:lpg_agency_locator/controllers/location.dart';
import 'package:lpg_agency_locator/views/landing_screen.dart';
import 'package:lpg_agency_locator/views/sharedWidgets/styled_button.dart';
import 'package:lpg_agency_locator/views/signUpScreen/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:location/location.dart' as lt;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _passwordVisible = false;
String _email = '';
String _password = '';

class _LoginScreenState extends State<LoginScreen> {
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
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: title1Style,
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
                      hintText: "Enter your email",
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
                          print("Password Visibility: $_passwordVisible");
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
                  //* email login button
                  StyledButton(
                    title: "Login",
                    onTap: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: _email, password: _password);
                        print(userCredential.user!.uid.toString());
                        print(userCredential.user!.email.toString());
                        Get.to(() => const LandingPage());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Get.snackbar('User does not exist',
                              'Please check the email entered');
                        } else if (e.code == 'wrong-password') {
                          Get.snackbar('Incorrect Password',
                              'Wrong password provided for the email');
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  StyledButton(
                    title: "Google Login",
                    onTap: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider
                          .googleLogIn()
                          .then((value) => Get.offAll(LandingPage()));
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Center(
                      child: Text(
                        "Don't have an account? Sign Up Now",
                        style: subtitle3Style,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
