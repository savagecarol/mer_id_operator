import 'package:flutter/material.dart';
import 'package:meri_id_operator/model/News.dart';
import 'package:meri_id_operator/services/widgets/CustomText.dart';
import 'package:meri_id_operator/utils/styles.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final Function ontap;
  NewsCard({required this.news , required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          elevation: 10,
          shadowColor: Styles.blackColor,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            child: Column(
              children: [
                SizedBox(height: 200, child: Image.network(news.urlToImage)),
                const SizedBox(
                  height: 16,
                ),
                CustomText.mediumText(news.title),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
