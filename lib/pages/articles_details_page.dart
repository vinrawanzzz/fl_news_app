//Now let's create the article details page

import 'package:NewsApp/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArticlePage extends StatefulWidget {
  final Article article;

  ArticlePage({this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  InAppWebViewController webView;
  final Color bgColor = Color.fromARGB(255, 26, 26, 26);
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(widget.article.source.name),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.855,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.article.url)),
                  onWebViewCreated: (controller) {
                    webView = controller;
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),
              ),
              _progress < 1
                  ? SizedBox(
                      height: 3,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.amber,
                        value: _progress,
                      ),
                    )
                  : SizedBox()
            ],
          )),
    );
  }
}
