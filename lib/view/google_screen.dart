import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/provider/mirror_wall_provider.dart';
import 'package:provider/provider.dart';
import 'components/botttom_navigation_bar.dart';
import 'components/pop_menu_button.dart';
import 'components/stream_builder.dart';

late InAppWebViewController inAppWebViewController;

TextEditingController txtsearch = TextEditingController();

PullToRefreshController pullToRefreshController =
    PullToRefreshController(onRefresh: () {
  inAppWebViewController.reload();
});

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<GoogleProvider>(context, listen: true);
    final providerFalse = Provider.of<GoogleProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<GoogleProvider>(context, listen: false)
                  .addToBookMark();
            },
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
          buildPopupMenuButton(providerTrue, providerFalse)
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: txtsearch,
              decoration: InputDecoration(
                hintText: 'Search Google or type a URL',
                fillColor: Colors.grey.shade300,
                suffixIcon: IconButton(
                    onPressed: () {
                      providerFalse.search(txtsearch.text);
                      if (providerFalse.uri.toString() ==
                          'https://duckduckgo.com/') {
                        inAppWebViewController.loadUrl(
                            urlRequest: URLRequest(
                                url: WebUri(
                                    '${providerFalse.uri}/?q=${providerFalse.searchText}&sca_esv=453cf80c9d34ac6b&sca_upv=1&rlz=1C1CHBD_enIN1099IN1101&sxsrf=ADLYWILO4ZE1r6P0Ha8wvoqAglAm7r1t5A%3A1716482160781&ei=cHBPZpCsL93V1e8PtZ-C2AM&ved=0ahUKEwiQpNOrmqSGAxXdavUHHbWPADsQ4dUDCBE&uact=5&oq=flutter&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyChAjGIAEGCcYigUyChAjGIAEGCcYigUyBBAjGCcyChAAGIAEGEMYigUyCxAAGIAEGLEDGIMBMggQABiABBixAzILEAAYgAQYsQMYgwEyCxAAGIAEGLEDGIoFMgsQABiABBixAxiDATIIEAAYgAQYsQNIphZQ5wpYnRJwAngBkAEBmAGmAqABug6qAQYwLjEyLjG4AQPIAQD4AQGYAgSgAskCwgIKEAAYsAMY1gQYR8ICDRAAGIAEGLADGEMYigXCAgUQABiABJgDAIgGAZAGCpIHAzIuMqAHgnM&sclient=gws-wiz-serp')));
                      } else {
                        inAppWebViewController.loadUrl(
                            urlRequest: URLRequest(
                                url: WebUri(
                                    '${providerFalse.uri}/search?q=${providerFalse.searchText}&sca_esv=453cf80c9d34ac6b&sca_upv=1&rlz=1C1CHBD_enIN1099IN1101&sxsrf=ADLYWILO4ZE1r6P0Ha8wvoqAglAm7r1t5A%3A1716482160781&ei=cHBPZpCsL93V1e8PtZ-C2AM&ved=0ahUKEwiQpNOrmqSGAxXdavUHHbWPADsQ4dUDCBE&uact=5&oq=flutter&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyChAjGIAEGCcYigUyChAjGIAEGCcYigUyBBAjGCcyChAAGIAEGEMYigUyCxAAGIAEGLEDGIMBMggQABiABBixAzILEAAYgAQYsQMYgwEyCxAAGIAEGLEDGIoFMgsQABiABBixAxiDATIIEAAYgAQYsQNIphZQ5wpYnRJwAngBkAEBmAGmAqABug6qAQYwLjEyLjG4AQPIAQD4AQGYAgSgAskCwgIKEAAYsAMY1gQYR8ICDRAAGIAEGLADGEMYigXCAgUQABiABJgDAIgGAZAGCpIHAzIuMqAHgnM&sclient=gws-wiz-serp')));
                      }
                    },
                    icon: const Icon(Icons.search)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BuildStreamBuilder(providerFalse, providerTrue),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
