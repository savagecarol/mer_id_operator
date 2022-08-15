import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

import '../../model/News.dart';
import '../../services/widgets/CustomText.dart';
import '../../utils/strings.dart';
import '../../utils/styles.dart';

class Feeds extends StatefulWidget {
  static const String routeNamed = 'Feeds';
  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  bool _isLoading = true;
  String value = "No GuideLines";
  List<News> news;
  @override
  void initState() {
    super.initState();

    _getNews();
  }

  _getNews() async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=in&q=government&apiKey=b959933666884935be61f74caa1c9a9b";
    Response res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if (body["status"] == 'ok') {
        print(body["totalResults"]);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styles.backgroundColor,
        appBar: AppBar(
          actions: [],
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Styles.blackColor,
          elevation: 0,
        ),
        body: (_isLoading)
            ? const Center(
                child: CircularProgressIndicator(color: Styles.redColor),
              )
            : SingleChildScrollView(
                child: Container(
                  color: Styles.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.xLargeText("News Feed"
                            // (_language)
                            //   ? StringValues.newsFeed.english
                            //   : StringValues.newsFeed.hindi,
                            ),
                        const SizedBox(
                          height: 64,
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
