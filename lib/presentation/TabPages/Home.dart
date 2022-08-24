import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meri_id_operator/model/Booking.dart';
import 'package:meri_id_operator/presentation/custom/CustomCard.dart';
import 'package:meri_id_operator/presentation/features/QRpage.dart';
import 'package:meri_id_operator/utils/global.dart';
import 'package:meri_id_operator/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/strings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _language = true;
  bool isLoading = true;
  List<Booking> bookList = [];

  void initState() {
    super.initState();
    _parent();
  }

  _parent() async {
    await _languageFunction();
    bookList = await apiService.getBooking();
    await _loadingOff();
  }

  _languageFunction() async {
    bool val = await checkLanguage();
    _language = val;
  }

  _loadingOff() {
    setState(() {
      isLoading = false;
    });
  }

  _navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  _navigateToQrPage() {
    Navigator.pushNamed(context, QRpage.routeNamed);
  }

  _bookListFetch() async {
    setState(() {
      isLoading = true;
    });
    bookList = await apiService.getBooking();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(
            child: CircularProgressIndicator(color: Styles.redColor),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText.xLargeText((_language)
                          ? StringValues.home.english
                          : StringValues.home.hindi),
                      IconButton(
                          onPressed: () {
                            _navigateToQrPage();
                          },
                          icon: const Icon(
                            Icons.qr_code,
                            size: 32,
                          ))
                    ],
                  ),
                  const SizedBox(height: 16),
                  (bookList.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 64, horizontal: 16),
                          child: SvgPicture.asset("assets/images/empty.svg"),
                        )
                      : Container(),
                  for (int i = 0; i < bookList.length; i++)
                    CustomCard(
                      address: bookList[i].address,
                      name: bookList[i].name,
                      booking_id: bookList[i].bookingId,
                      date: bookList[i].day,
                      time: bookList[i].timeSlot,
                      lat: double.parse(bookList[i].lat),
                      long: double.parse(bookList[i].long),
                      onMapClick: () {
                        _navigateTo(double.parse(bookList[i].lat),
                            double.parse(bookList[i].long));
                      },
                      persons: int.parse(bookList[i].numberofPeople),
                      onTap: () {},
                      isStart: bookList[i].status == "accepted" ? true : false,
                      makeCall: () async {
                        if (bookList[i].status == "accepted") {
                          try {
                            bool val = await apiService
                                .updateBooking(bookList[i].uuid);
                            if (val) successToast("Ready To Proceed", context);
                            errorToast("!OOps Some Error Occur", context);
                            _bookListFetch();
                          } catch (e) {
                            errorToast("!OOps Some Error Occur", context);
                          }
                        } else {
                          launchUrlString("tel:+91${bookList[i].number}");
                        }
                      },
                    ),
                ],
              ),
            ),
          );
  }
}
