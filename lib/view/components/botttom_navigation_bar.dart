import 'package:flutter/material.dart';

import '../google_screen.dart';

Row bottomNavigationBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
          onPressed: () {
            inAppWebViewController.goBack();
          },
          icon: const Icon(Icons.arrow_back_ios_new)),
      IconButton(
          onPressed: () {
            inAppWebViewController.goForward();
          },
          icon: const Icon(Icons.arrow_forward_ios_outlined)),
      IconButton(
          onPressed: () {
            inAppWebViewController.reload();
          },
          icon: const Icon(Icons.refresh)),
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.add_box_outlined)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
    ],
  );
}