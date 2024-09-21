import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:news_app/widgets/vertical_spacing_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late final WebViewController _controller;
  double _progress = 0.0;

  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onHttpError: (HttpResponseError error) {
            // Handle HTTP error with generic message
            print('HTTP error occurred. Details may not be available.');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('Navigation to YouTube blocked');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "https://techcrunch.com/2022/06/17/marc-lores-food-delivery-startup-wonder-raises-350m-3-5b-valuation/"));
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).iconTheme.color ?? Colors.black;

    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false; // Stay inside the WebView
        }
        return true; // Exit the WebView
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(color: color),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "WebView",
            style: TextStyle(color: color),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await _showModalSheetFct();
              },
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalSheetFct() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalSpacing(20),
              Center(
                child: Container(
                  height: 5,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              VerticalSpacing(20),
              Text(
                'More Options',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              VerticalSpacing(20),
              Divider(
                thickness: 2,
              ),
              VerticalSpacing(20),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () async {
                  try {
                    await Share.share(
                      'Check out this news article: ${widget.url}',
                    );
                  } catch (err) {
                    GlobalMethods.errorDialog(
                        errormessage:  err.toString(), context: context);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.open_in_browser),
                title: Text('Open in Browser'),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(widget.url))) {
                    throw Exception('Could not launch ${widget.url}');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Refresh'),
                onTap: () async {
                  try {
                    await _controller.reload();
                  } catch (err) {
                    print('Error ocuured $err');
                  } finally {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
