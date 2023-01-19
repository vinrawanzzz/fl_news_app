// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:NewsApp/main.dart';
import 'package:NewsApp/model/article_model.dart';
import 'package:NewsApp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test fetching news articles', (WidgetTester tester) async {
    List<Article> articles = await ApiService.getArticle("general");
    expect(articles.length, greaterThan(0));
  });
}
