import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:meri_id_operator/presentation/auth/FirstPage.dart';

import '../utils/global.dart';
import '../utils/styles.dart';
import 'TabPages/Attendance.dart';
import 'TabPages/Home.dart';
import 'TabPages/Profile.dart';

class SplashPage extends StatefulWidget {
  static const String routeNamed = 'SplashPage';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _getBody() {
    switch (currentPage) {
      case 0:
        return const Home();
      case 1:
        return const Attendance();
      case 2:
        return const Profile();
      default:
        return const Home();
    }
  }

    @override
  void initState() {
    super.initState();
    cronJob();
  }


Future<void>  cronJob() async{
  final cron = Cron();
  cron.schedule(Schedule.parse('*/15 * * * * *'), () async {
    await startService.doRun();
      if (userProfile.status == "disable") {
        await preferenceService.setUID("");
        Navigator.pushNamed(context, FirstPage.routeNamed);
      }
    });
}


  _getBottomBar() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Styles.creamColor,
          boxShadow: [
            BoxShadow(
                color: Styles.creamColor, blurRadius: 10, offset: Offset(4, 2))
          ]),
      child: Card(
        color: Styles.creamColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getBottomBarItem(index: 0, icontab: Icons.home, text: "Home"),
            _getBottomBarItem(
                index: 1, icontab: Icons.calendar_month, text: "Attendance"),
            _getBottomBarItem(
                index: 2, icontab: Icons.account_circle, text: "Profile"),
          ],
        ),
      ),
    );
  }

  _getBottomBarItem(
      {required int index, required IconData icontab, required String text}) {
    return InkWell(
      onTap: () {
        setState(() {
          currentPage = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color:
                    currentPage == index ? Styles.redColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icontab,
                        color: currentPage == index
                            ? Styles.backgroundColor
                            : Styles.blackColor,
                        size: (28)),
                    // (currentPage == index) ? Container(margin:const EdgeInsets.only(left: 8) ,child: CustomText.smalltext(text)) : const Text('')
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: _getBottomBar(),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Expanded(child: _getBody())],
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Styles.grayColor,
              elevation: 12,
              tooltip: 'chat bot',
              child: const Icon(Icons.help, color: Styles.blackColor),
              onPressed: () async {
                try {
                  dynamic conversationObject = {
                    'appId': '259ee76a76674e8ee1a6d02613a91595f'
                  };
                  dynamic result =
                      await KommunicateFlutterPlugin.buildConversation(
                          conversationObject);
                  print("Conversation builder success : " + result.toString());
                } on Exception catch (e) {
                  print(
                      "Conversation builder error occurred : " + e.toString());
                }
              })),
    );
  }
}
