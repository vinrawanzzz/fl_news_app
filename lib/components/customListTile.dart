import 'package:NewsApp/model/article_model.dart';
import 'package:NewsApp/pages/articles_details_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

final Color bgColor = Color.fromARGB(255, 26, 26, 26);
final Color itm1Color = Colors.white54;

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(
                    article: article,
                  )));
    },
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            article.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.source.name,
                style: TextStyle(
                  color: itm1Color,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await Share.share(
                      article.url,
                      subject: "Url",
                    );
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    color: itm1Color,
                  ))
            ],
          ),
          SizedBox(
            height: 1,
            child: Container(
              color: itm1Color,
            ),
          )
        ],
      ),
    ),
  );
}
