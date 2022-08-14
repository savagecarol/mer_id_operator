import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/auth/FirstPage.dart';
import 'package:meri_id_operator/presentation/auth/PhoneNumber.dart';
import 'package:meri_id_operator/presentation/auth/otp.dart';
import 'package:meri_id_operator/presentation/features/Info.dart';
import 'package:meri_id_operator/presentation/features/Issue.dart';
import 'package:meri_id_operator/presentation/features/Language.dart';
import 'package:meri_id_operator/presentation/features/QRpage.dart';
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
        initialRoute: FirstPage.routeNamed,
        routes: {
          SplashPage.routeNamed: (BuildContext context) => SplashPage(),
          FirstPage.routeNamed: (BuildContext context) => FirstPage(),
          SvgScreen.routeNamed: (BuildContext context) => const SvgScreen(),
          Feeds.routeNamed: (BuildContext context) => Feeds(),
          LanguagePage.routeNamed: (BuildContext context) => LanguagePage(),
          Issue.routeNamed: (BuildContext context) => Issue(),
          Info.routeNamed: (BuildContext context) => Info(),
          OTP.routeNamed: (BuildContext context) => OTP(),
          PhoneNumber.routeNamed: (BuildContext context) => PhoneNumber(),
          QRpage.routeNamed: (BuildContext context) => QRpage()
               
        });
  }
}
