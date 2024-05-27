import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../provider/mirror_wall_provider.dart';
import '../google_screen.dart';

StreamBuilder<List<ConnectivityResult>> BuildStreamBuilder(GoogleProvider providerFalse, GoogleProvider providerTrue) {
  return StreamBuilder(
    builder: (context, snapshot) {
      if (snapshot.data!.contains(ConnectivityResult.mobile) ||
          snapshot.data!.contains(ConnectivityResult.wifi)) {
        return Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri(
                      'https://www.google.com/search?q=${Provider.of<GoogleProvider>(context, listen: false).searchText}&sca_esv=453cf80c9d34ac6b&sca_upv=1&rlz=1C1CHBD_enIN1099IN1101&sxsrf=ADLYWILO4ZE1r6P0Ha8wvoqAglAm7r1t5A%3A1716482160781&ei=cHBPZpCsL93V1e8PtZ-C2AM&ved=0ahUKEwiQpNOrmqSGAxXdavUHHbWPADsQ4dUDCBE&uact=5&oq=flutter&gs_lp=Egxnd3Mtd2l6LXNlcnAiB2ZsdXR0ZXIyChAjGIAEGCcYigUyChAjGIAEGCcYigUyBBAjGCcyChAAGIAEGEMYigUyCxAAGIAEGLEDGIMBMggQABiABBixAzILEAAYgAQYsQMYgwEyCxAAGIAEGLEDGIoFMgsQABiABBixAxiDATIIEAAYgAQYsQNIphZQ5wpYnRJwAngBkAEBmAGmAqABug6qAQYwLjEyLjG4AQPIAQD4AQGYAgSgAskCwgIKEAAYsAMY1gQYR8ICDRAAGIAEGLADGEMYigXCAgUQABiABJgDAIgGAZAGCpIHAzIuMqAHgnM&sclient=gws-wiz-serp')),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                providerFalse.onProgress(progress);
              },
              onLoadStop: (controller, url) {
                providerFalse.currentUrlLink(url.toString());
                pullToRefreshController.endRefreshing();
              },
              pullToRefreshController: pullToRefreshController,
            ),
            (providerTrue.progress < 1)
                ? Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                value: Provider.of<GoogleProvider>(context).progress,
              ),
            )
                : const Column(),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50, left: 90),
              child: Image(image: AssetImage('assets/image/network.png')),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                'Whoops!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                'No Internet Connection Found \n Check Your Connection',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 50),
              child: Container(
                height: 60,
                width: 180,
                decoration: BoxDecoration(
                    color: const Color(0xffFE3D6A),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    },
    stream: Connectivity().onConnectivityChanged,
  );
}