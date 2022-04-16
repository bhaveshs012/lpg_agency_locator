import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lpg_agency_locator/config/fonts.dart';
import 'package:lpg_agency_locator/controllers/google_signin.dart';
import 'package:lpg_agency_locator/views/homeScreen/homescreen.dart';
import 'package:lpg_agency_locator/views/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //created to initialize provider package
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        builder: (context, _) {
          return Sizer(builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                splashIconSize: 300,
                splash: Lottie.network(
                    'https://assets8.lottiefiles.com/packages/lf20_lpmjb80e.json'),
                nextScreen: const HomeScreen(),
              ),
            );
          });
        });
  }
}
