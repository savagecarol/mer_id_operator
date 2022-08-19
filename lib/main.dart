import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meri_id_operator/presentation/SplashPage.dart';
import 'package:meri_id_operator/presentation/auth/FirstPage.dart';
import 'package:meri_id_operator/presentation/auth/PhoneNumber.dart';
import 'package:meri_id_operator/presentation/features/Info.dart';
import 'package:meri_id_operator/presentation/features/Issue.dart';
import 'package:meri_id_operator/presentation/features/Language.dart';
import 'package:meri_id_operator/presentation/features/QRpage.dart';
import 'package:meri_id_operator/presentation/features/Selfie.dart';
import 'presentation/features/Feeds.dart';
import 'utils/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final cron = Cron();
  cron.schedule(Schedule.parse('*/15 * * * * *'), () async {
    print('every 15 seconds Lesgooooooooooooooooooooooooooo');
  });
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
        initialRoute: Selfie.routeNamed,
        routes: {
          SplashPage.routeNamed: (BuildContext context) => SplashPage(),
          FirstPage.routeNamed: (BuildContext context) => FirstPage(),
          Feeds.routeNamed: (BuildContext context) => Feeds(),
          LanguagePage.routeNamed: (BuildContext context) => LanguagePage(),
          Issue.routeNamed: (BuildContext context) => Issue(),
          Info.routeNamed: (BuildContext context) => Info(),
          PhoneNumber.routeNamed: (BuildContext context) => PhoneNumber(),
          Selfie.routeNamed: (BuildContext context) => Selfie(),
        });
  }
}
