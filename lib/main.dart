import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_for_change/Providers/complaint.dart';
import 'package:we_for_change/Providers/notificationPro.dart';
import 'package:we_for_change/Providers/user.dart';
import 'package:we_for_change/Screen/ContactUs.dart';
import 'package:we_for_change/Screen/Dashboard.dart';
import 'package:we_for_change/Utils/SharedPreferencesHelper.dart';
import 'Constant/Constant.dart';
import 'Screen/ForgotPassword.dart';
import 'Screen/Login_page.dart';
import 'Screen/Plash_Screen.dart';
import 'Screen/Registration_Page.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(WeForChange());
}

class WeForChange extends StatefulWidget {
  const WeForChange({key}) : super(key: key);

  @override
  _WeForChangeState createState() => _WeForChangeState();
}

class _WeForChangeState extends State<WeForChange> {
  Widget _defaultHome = new ImageSplashScreen();

  defaultHome() async {
    String authToken = await SharedPreferencesHelper.getAuthToken();

    _defaultHome = new ImageSplashScreen();
    if (authToken != null) {
      _defaultHome = Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveWrapper.builder(BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: Color(0xFFF5F5F5)));
    // MediaQueryData mediaQueryData = MediaQuery.of(context);
    // double height = mediaQueryData.size.height;
    // double width = mediaQueryData.size.width;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ComplaintProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 0,
            ),
            accentColor: Colors.grey,
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 22.0, color: Colors.black),
              headline2: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          home: _defaultHome,
          // routes: <String, WidgetBuilder>{
          //   SIGNUP_SCREEN: (BuildContext context) => new RegistrationPage(),
          //   SIGNIN_SCREEN: (BuildContext context) => new LoginPage(),
          //   IMAGE_SPLASH: (BuildContext context) => new ImageSplashScreen(),
          //   FORGOT_PASSWORD: (BuildContext context) => new ForgotPassword(),
          //   CONTACT_US: (BuildContext context) => new ContactUs(),
          // }
        ));
  }
}
