import 'dart:convert';

import 'package:NewsApp/model/article_model.dart';
import 'package:http/http.dart';

class ApiService {
  static Future<List<Article>> getArticle(category) async {
    final endPointUrl =
        "http://newsapi.org/v2/top-headlines?country=id&category=${category}&apiKey=8697a47a009a47dfb9c3d185a23a23cb";
    Response res = await get(endPointUrl).timeout(
      Duration(seconds: 30),
      onTimeout: () {
        return;
      },
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
