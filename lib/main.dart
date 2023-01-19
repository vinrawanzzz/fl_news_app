import 'dart:io';

import 'package:NewsApp/services/api_service.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'components/customListTile.dart';
import 'model/article_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final Color bgColor = Color.fromARGB(255, 26, 26, 26);
String tag = "General";
List<String> options = [
  'General',
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Technology',
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("My News", style: TextStyle(color: Colors.white)),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        onSelected: (value) {
                          setState(() => tag = options[index]);
                        },
                        backgroundColor: bgColor,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        label: Text(
                          options[index],
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: tag == options[index] ? true : false,
                      ),
                    );
                  },
                )),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiService.getArticle(tag.toLowerCase()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Article>> snapshot) {
                if (snapshot.hasData) {
                  List<Article> articles = snapshot.data;
                  return RefreshIndicator(
                    onRefresh: () {
                      setState(() {});
                      return Future.value();
                    },
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) =>
                          customListTile(articles[index], context),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CardLoading(
                        height: 300,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
