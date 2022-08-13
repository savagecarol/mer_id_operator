import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/auth/FirstPage.dart';
import 'package:meri_id_operator/presentation/auth/LoginPage.dart';
import 'package:meri_id_operator/presentation/auth/otp.dart';
import 'package:meri_id_operator/presentation/features/AddFriend.dart';
import 'package:meri_id_operator/presentation/features/BookingDetail.dart';
import 'package:meri_id_operator/presentation/features/ChooseAddress.dart';
import 'package:meri_id_operator/presentation/features/ChooseTimeSlot.dart';
import 'package:meri_id_operator/presentation/features/GoogleMapTracking.dart';
import 'package:meri_id_operator/presentation/features/Info.dart';
import 'package:meri_id_operator/presentation/features/Issue.dart';
import 'package:meri_id_operator/presentation/features/Language.dart';
import 'package:meri_id_operator/presentation/features/SvgScreen.dart';
import 'presentation/features/Feeds.dart';
import 'utils/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: StringValues.appName.english,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
        initialRoute: LoginPage.routeNamed,
        routes: {
          SplashPage.routeNamed: (BuildContext context) => SplashPage(),
          FirstPage.routeNamed: (BuildContext context) => FirstPage(),
          OTP.routeNamed: (BuildContext context) => OTP(),
          LoginPage.routeNamed: (BuildContext context) => LoginPage(),
          AddFriend.routeNamed: (BuildContext context) => AddFriend(),
          SvgScreen.routeNamed: (BuildContext context) => const SvgScreen(),
          GoogleMapTracking.routeNamed: (BuildContext context) =>
              const GoogleMapTracking(),
          Feeds.routeNamed: (BuildContext context) => Feeds(),
          LanguagePage.routeNamed: (BuildContext context) => LanguagePage(),
          Issue.routeNamed: (BuildContext context) => Issue(),
          Info.routeNamed: (BuildContext context) => Info(),
          ChooseTimeSlot.routeNamed: (BuildContext context) =>
              const ChooseTimeSlot(),
          ChooseAddress.routeNamed: (BuildContext context) =>
              const ChooseAddress(),
          BookingDetail.routeNamed: (BuildContext context) =>
              const BookingDetail(),
        });
  }
}
